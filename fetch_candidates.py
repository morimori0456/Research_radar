#!/usr/bin/env python3
"""Stage 1: arXiv から候補を収集して candidates.json に出力。

topics.yaml の各トピックのカテゴリ/キーワードで arXiv API を叩き、
lookback_days 以内の新着を集める。標準ライブラリのみ。
"""
import json
import sys
import time
import urllib.parse
import urllib.request
import xml.etree.ElementTree as ET
from datetime import datetime, timedelta, timezone
from pathlib import Path

ARXIV_API = "http://export.arxiv.org/api/query"
NS = {"a": "http://www.w3.org/2005/Atom"}


def load_topics(path: Path) -> dict:
    """依存を増やさないための極小 YAML パーサ (このファイル構造専用)。"""
    import re
    text = path.read_text()
    global_cfg = {"max_deep_per_day": 5, "lookback_days": 2}
    m = re.search(r"max_deep_per_day:\s*(\d+)", text)
    if m: global_cfg["max_deep_per_day"] = int(m.group(1))
    m = re.search(r"lookback_days:\s*(\d+)", text)
    if m: global_cfg["lookback_days"] = int(m.group(1))

    topics = []
    for block in re.split(r"\n\s*-\s*name:", text)[1:]:
        name = block.splitlines()[0].strip()
        proj = re.search(r"project:\s*(\S+)", block)
        cats = re.search(r"arxiv_categories:\s*\[([^\]]+)\]", block)
        quota = re.search(r"quota:\s*(\d+)", block)
        kws = re.findall(r'-\s*"([^"]+)"', block)
        topics.append({
            "name": name,
            "project": proj.group(1) if proj else "?",
            "categories": [c.strip() for c in cats.group(1).split(",")] if cats else [],
            "keywords": kws,
            "quota": int(quota.group(1)) if quota else 1,
        })
    return {"global": global_cfg, "topics": topics}


def query_arxiv(categories, keywords, max_results=30):
    cat_q = " OR ".join(f"cat:{c}" for c in categories)
    kw_q = " OR ".join(f'abs:"{k}"' for k in keywords)
    search = f"({cat_q}) AND ({kw_q})" if kw_q else f"({cat_q})"
    params = {
        "search_query": search,
        "sortBy": "submittedDate",
        "sortOrder": "descending",
        "max_results": str(max_results),
    }
    url = f"{ARXIV_API}?{urllib.parse.urlencode(params)}"
    req = urllib.request.Request(url, headers={"User-Agent": "research-loop/1.0"})
    with urllib.request.urlopen(req, timeout=30) as r:
        return r.read()


def parse_entries(xml_bytes, cutoff):
    root = ET.fromstring(xml_bytes)
    out = []
    for e in root.findall("a:entry", NS):
        pub = e.find("a:published", NS).text
        pub_dt = datetime.strptime(pub, "%Y-%m-%dT%H:%M:%SZ").replace(tzinfo=timezone.utc)
        if pub_dt < cutoff:
            continue
        out.append({
            "id": e.find("a:id", NS).text.split("/abs/")[-1],
            "title": " ".join(e.find("a:title", NS).text.split()),
            "abstract": " ".join(e.find("a:summary", NS).text.split()),
            "authors": [a.find("a:name", NS).text
                        for a in e.findall("a:author", NS)][:5],
            "published": pub,
            "url": e.find("a:id", NS).text,
        })
    return out


def main():
    here = Path(__file__).parent
    cfg = load_topics(here / "topics.yaml")
    cutoff = datetime.now(timezone.utc) - timedelta(days=cfg["global"]["lookback_days"])

    candidates = []
    seen = set()
    for t in cfg["topics"]:
        print(f"[fetch] {t['name']} ({t['project']}) ...", file=sys.stderr)
        try:
            xml = query_arxiv(t["categories"], t["keywords"])
            entries = parse_entries(xml, cutoff)
        except Exception as ex:
            print(f"[fetch]   error: {ex}", file=sys.stderr)
            entries = []
        for e in entries:
            if e["id"] in seen:
                continue
            seen.add(e["id"])
            e["topic"] = t["name"]
            e["project"] = t["project"]
            e["quota"] = t["quota"]
            candidates.append(e)
        print(f"[fetch]   {len(entries)} new", file=sys.stderr)
        time.sleep(3)  # arXiv API のレート制限を尊重

    out_path = here / "candidates.json"
    out_path.write_text(json.dumps({
        "generated_at": datetime.now(timezone.utc).isoformat(),
        "max_deep_per_day": cfg["global"]["max_deep_per_day"],
        "candidates": candidates,
    }, ensure_ascii=False, indent=2))
    print(f"[fetch] {len(candidates)} candidates -> {out_path}", file=sys.stderr)


if __name__ == "__main__":
    main()
