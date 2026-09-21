# Starters Labo FAQ skill

Unofficial [Cursor](https://cursor.com) / [Claude](https://claude.ai) skill that logs into [mijn.starterslabo.be](https://mijn.starterslabo.be), crawls the FAQ (and attachments), and answers questions from that local corpus.

Not affiliated with Starterslabo. You need your own portal login. Credentials are never stored in this repo.

## Install

Clone this repo **as the skill folder** (it must contain `SKILL.md` at the root):

```bash
# Cursor — this project
git clone https://github.com/c1sc0c0/starterslabo-faq.git .cursor/skills/starterslabo-faq

# Cursor — all projects
git clone https://github.com/c1sc0c0/starterslabo-faq.git ~/.cursor/skills/starterslabo-faq

# Claude Code — this project
git clone https://github.com/c1sc0c0/starterslabo-faq.git .claude/skills/starterslabo-faq

# Claude Code — all projects
git clone https://github.com/c1sc0c0/starterslabo-faq.git ~/.claude/skills/starterslabo-faq
```

Restart the agent chat (or Cursor/Claude Code) so it picks up the skill.

**Claude.ai:** zip this folder and upload it as a custom skill.

## Use

Tell the agent something like:

> Ingest the mijn.starterslabo FAQ. Username: you@example.com Password: •••••• Then tell me how the werkingsbijdrage works.

The agent will:

1. Ask for username/password if you did not provide them
2. Run `scripts/crawl_faq.py` (Playwright)
3. Write `starterslabo-faq-corpus/` next to your project
4. Answer from `FAQ.md`, `public-faq.md`, and `extracted/`

Do not paste credentials into a public chat. Prefer a local Cursor/Claude Code session.

## Manual crawl

```bash
cd /path/to/starterslabo-faq
python3 -m venv .venv
.venv/bin/pip install -r scripts/requirements.txt
.venv/bin/playwright install chromium

STARTERSLABO_EMAIL='you@example.com' STARTERSLABO_PASSWORD='your-password' \
  .venv/bin/python scripts/crawl_faq.py --output ./starterslabo-faq-corpus
```

Never commit `.env`, `starterslabo-faq-corpus/`, or FAQ PDFs.

## What gets crawled

- Logged-in portal FAQ: `https://mijn.starterslabo.be/Views/FAQ.aspx`
- Public programme FAQ: `https://starterslabo.be/faq/`
- FAQ bijlagen (PDF/DOCX/XLSX), extracted to text for Q&A

Portal FAQ content belongs to Starterslabo. Keep the crawl on your machine for personal use; do not republish the handleidingen.

## License

MIT for this skill’s code and instructions. Starterslabo’s website, portal, and documents remain theirs.
