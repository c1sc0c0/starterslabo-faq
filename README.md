# Starters Labo FAQ skill

Unofficial helper for [Cursor](https://cursor.com) and [Claude](https://claude.ai). It teaches the assistant how to read the Starterslabo FAQ (portal + public site) and answer questions from it.

Not affiliated with Starterslabo. Never put your portal password in this GitHub repo.

**Most people should use the Claude desktop app.** You type your Starterslabo password on the login **website**, never in the chat.

- **Claude app:** [download the zip](https://github.com/c1sc0c0/starterslabo-faq/releases/latest/download/starterslabo-faq.zip) → follow [Claude (website or app)](#claude-website-or-app)
- **Cursor or Claude Code:** follow [On your computer](#on-your-computer-cursor-or-claude-code)

---

## Claude (website or app)

Use the [Claude desktop app](https://claude.com/download) (Pro or Max). That gives you a **browser next to the chat**. You type your Starterslabo password **on the website**, not in the conversation. Claude is not allowed to type passwords for you — that is an Anthropic rule, and it is the safe way.

You need: the desktop app, the skill zip, and a new chat. No terminal.

### How login works (this is the important bit)

```
You  →  type email + password in the Starterslabo login form (the website)
          not in the Claude message box

Claude → opens the page, waits, then reads the FAQ after you are in
```

Never paste your password into the chat. If Claude asks you to, say: *I'll type it in the website form — continue when I'm in.*

### Nederlands — installeren en inloggen

1. Installeer de **Claude-app** van [claude.com/download](https://claude.com/download) en log in.  
   Skills + ingebouwde browser zitten op **Pro/Max**. In de app: **Settings → Capabilities** → **Code execution and file creation** aan.

2. Download [starterslabo-faq.zip](https://github.com/c1sc0c0/starterslabo-faq/releases/latest/download/starterslabo-faq.zip).  
   **Niet uitpakken.** Niet de groene knop **Code → Download ZIP** op GitHub gebruiken.

3. **Customize → Skills → + → Create skill → Upload a skill** → kies die zip. Zet **starterslabo-faq** op **aan**.

4. Nieuw gesprek, typ:  
   *Gebruik de Starters Labo FAQ skill. Open mijn.starterslabo.be, ik log zelf in, daarna lees je de FAQ. Daarna: moet ik BTW rekenen op verzending?*

5. Er opent een browservenster naast de chat met de **Inloggen**-pagina van Starterslabo.  
   Vul daar **e-mail** en **wachtwoord** in (zoals op elke website) en klik **Inloggen**.  
   Zeg in de chat: *Ik ben ingelogd, ga verder.*

6. Claude opent daarna de FAQ en beantwoordt je vraag.

**Al in Chrome ingelogd?** Bij de eerste browser in Cowork kun je **Import cookies** kiezen voor `mijn.starterslabo.be`. Dan hoef je het wachtwoord deze keer niet opnieuw te typen.

**Geen browservenster?** Je zit waarschijnlijk alleen op claude.ai in Safari/Chrome zonder de desktop-app. Installeer de app; zonder dat venster kan Claude het portaal niet veilig openen.

### English — install and sign in

1. Install the **Claude app** from [claude.com/download](https://claude.com/download). Enable **Settings → Capabilities → Code execution and file creation**.

2. Download [starterslabo-faq.zip](https://github.com/c1sc0c0/starterslabo-faq/releases/latest/download/starterslabo-faq.zip). **Do not unzip.** Do not use GitHub **Code → Download ZIP**.

3. **Customize → Skills → + → Create skill → Upload a skill** → that zip. Toggle **starterslabo-faq** on.

4. New chat:  
   *Use the Starters Labo FAQ skill. Open mijn.starterslabo.be, I'll log in myself, then read the FAQ. Then: do I charge VAT on shipping?*

5. A browser panel opens on the Starterslabo **Inloggen** page. Type your email and password **there**, click **Inloggen**, then tell Claude *I'm in, continue.*

6. Claude reads the FAQ and answers.

Already signed in in Chrome? Use **Import cookies** for `mijn.starterslabo.be` when Cowork first opens a browser.

No browser panel? Use the desktop app, not a plain website tab.

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
