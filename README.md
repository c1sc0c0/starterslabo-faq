# Starters Labo FAQ skill

Unofficial helper for [Cursor](https://cursor.com) and [Claude](https://claude.ai). It teaches the assistant how to read the Starterslabo FAQ (portal + public site) and answer questions from it.

Not affiliated with Starterslabo. Never put your portal password in this GitHub repo.

**Most people should use Claude in the browser or the Claude app.** You do not need a terminal.

- **Claude (website / app):** [download the zip](https://github.com/c1sc0c0/starterslabo-faq/releases/latest/download/starterslabo-faq.zip) → follow [Claude (website or app)](#claude-website-or-app)
- **Cursor or Claude Code:** follow [On your computer](#on-your-computer-cursor-or-claude-code)

---

## Claude (website or app)

This is the path if you only use [claude.ai](https://claude.ai) or the Claude desktop app.

### Nederlands — in 6 stappen

1. **Download het zip-bestand**  
   Klik hier: [starterslabo-faq.zip](https://github.com/c1sc0c0/starterslabo-faq/releases/latest/download/starterslabo-faq.zip).  
   **Pak het bestand niet uit.** Je uploadt de zip zoals hij is.  
   Gebruik niet de groene knop **Code → Download ZIP** op GitHub — dat bestand werkt niet in Claude.

2. **Zet Skills aan**  
   Open Claude → **Settings** (tandwiel) → **Capabilities**.  
   Zet **Code execution and file creation** aan. Zonder dit werkt de skill niet.

3. **Upload de skill**  
   Ga naar **Customize → Skills**.  
   Klik op **+**, kies **+ Create skill**, daarna **Upload a skill**.  
   Kies het bestand `starterslabo-faq.zip`.

4. **Zet de skill aan**  
   In de lijst bij **Skills** moet **starterslabo-faq** op **aan** (groene schakelaar) staan.

5. **Start een nieuw gesprek** en typ bijvoorbeeld:  
   *Gebruik de Starters Labo FAQ skill. Moet ik BTW rekenen op verzendkosten?*  
   of: *Lees https://starterslabo.be/faq/ en leg uit hoe lang het LABO-traject duurt.*

6. **Wachtwoord**  
   Typ **nooit** je wachtwoord van mijn.starterslabo.be in Claude op het web.  
   Voor de **openbare** FAQ (starterslabo.be) is geen login nodig.  
   Voor de **privé-FAQ in het portaal**: log zelf in op [mijn.starterslabo.be](https://mijn.starterslabo.be), open **FAQ**, kopieer het artikel, en plak het in Claude.

**Upload mislukt?** Je hebt waarschijnlijk het verkeerde zip-bestand. Download opnieuw via de link hierboven. De map in de zip moet `starterslabo-faq` heten.

### English — same 6 steps

1. **Download the zip**  
   Click: [starterslabo-faq.zip](https://github.com/c1sc0c0/starterslabo-faq/releases/latest/download/starterslabo-faq.zip).  
   **Do not unzip it.** Upload the zip as-is.  
   Do not use GitHub’s green **Code → Download ZIP** button — Claude will reject that file.

2. **Turn Skills on**  
   Claude → **Settings** (gear) → **Capabilities**.  
   Enable **Code execution and file creation**.

3. **Upload the skill**  
   **Customize → Skills** → **+** → **+ Create skill** → **Upload a skill** → pick `starterslabo-faq.zip`.

4. **Enable it**  
   Toggle **starterslabo-faq** on in your Skills list.

5. **Start a new chat**, for example:  
   *Use the Starters Labo FAQ skill. Do I need to charge VAT on shipping?*  
   or: *Read https://starterslabo.be/faq/ and explain how long the LABO trajectory lasts.*

6. **Passwords**  
   Never type your mijn.starterslabo.be password into Claude on the web.  
   The **public** FAQ needs no login. For the **private portal FAQ**, log in yourself, copy the article, and paste it into the chat.

Claude in the browser **cannot** log into the portal for you. Automatic login only works on your computer (section below).

---

## On your computer (Cursor or Claude Code)

Use this if you want the assistant to log into mijn.starterslabo.be and download the full portal FAQ (including PDFs).

### Install

The folder must be named `starterslabo-faq` and contain `SKILL.md` at the top.

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

Start a new agent chat so the skill is picked up.

### Ingest (with your own login)

In a **local** Cursor or Claude Code chat (not claude.ai):

> Ingest the mijn.starterslabo FAQ. Username: you@example.com Password: ••••••

Or run the crawler yourself:

```bash
cd /path/to/starterslabo-faq
python3 -m venv .venv
.venv/bin/pip install -r scripts/requirements.txt
.venv/bin/playwright install chromium

STARTERSLABO_EMAIL='you@example.com' STARTERSLABO_PASSWORD='your-password' \
  .venv/bin/python scripts/crawl_faq.py --output ./starterslabo-faq-corpus
```

Never commit `.env`, `starterslabo-faq-corpus/`, or FAQ PDFs.

Rebuild the Claude zip after you change the skill:

```bash
./scripts/pack-skill.sh
```

---

## What gets read

- Public FAQ: [starterslabo.be/faq](https://starterslabo.be/faq/)
- Logged-in FAQ (computer only): [mijn.starterslabo.be/Views/FAQ.aspx](https://mijn.starterslabo.be/Views/FAQ.aspx)
- FAQ attachments (PDF/DOCX/XLSX), extracted to text

Portal documents belong to Starterslabo. Keep crawls on your machine; do not republish the handleidingen.

## License

MIT for this skill’s code and instructions. Starterslabo’s website, portal, and documents remain theirs.
