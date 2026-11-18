# Hair Colour Tier Vote

A voting-based tier maker with six categories of animated characters:
Redheads, Blondes, Brunettes, Black Hair, White & Silver, and Colourful.

Each category has 50 characters (25 Western, 25 Eastern). A voter ranks 30 polls of 5.
Every character appears in exactly 3 polls, and their average points (4 for 1st down to 0 for 5th)
decide their tier.

| Tier | Average points |
|---|---|
| S | 3.2 or more |
| A | 2.4 or more |
| B | 1.6 or more |
| C | 0.8 or more |
| D | below 0.8 |

Each category has its own link, so you can share one directly:
`.../#redheads`, `#blondes`, `#brunettes`, `#black`, `#white`, `#colourful`.

## Files

| File | What it is |
|---|---|
| `index.html` | The whole app |
| `characters.js` | All six rosters plus each category's title, colours and placeholder style. Keep each roster a multiple of 5 |
| `config.js` | Thumbnail extension and optional Supabase keys for shared voting |
| `thumbs/<category>/` | Thumbnails for that category. Each folder's `README.md` lists the exact filenames |
| `supabase.sql` | Database setup for shared voting |

## 1. Host it on GitHub Pages

1. Push this folder to your repository:
   ```bash
   git init
   git add .
   git commit -m "Hair colour tier vote"
   git branch -M main
   git remote add origin https://github.com/gvargr/RHT.git
   git push -u origin main
   ```
   If the repo already has commits (for example a README made on GitHub), run
   `git pull origin main --allow-unrelated-histories` before pushing.
2. In the repo go to **Settings > Pages**, set **Source** to *Deploy from a branch*, branch `main`, folder `/ (root)`, and save.
3. After a minute the site is live at `https://gvargr.github.io/RHT/`.

## 2. Add thumbnails

Put square images in the matching category folder, named after the character id,
e.g. `thumbs/redheads/ariel.webp` or `thumbs/colourful/zerotwo.webp`.
512x512 WebP works well. Missing images show a coloured initials placeholder, so you can add them gradually.

To use PNG or JPG for everything, change `thumbExt` in `config.js`.
To override a single image, add it to `IMG_OVERRIDES` at the bottom of `characters.js`.

## 3. Turn on shared voting (optional)

GitHub Pages only serves static files, so on its own each visitor only sees their own results.
To combine everyone's votes, use a free Supabase project:

1. Create a project at supabase.com.
2. Open **SQL Editor**, paste in `supabase.sql`, and run it. It is safe to re-run, and it upgrades the older redheads-only table if you already set that up.
3. Open **Project Settings > API** and copy the **Project URL** and the **anon public** key.
4. Paste both into `config.js`, then commit and push.

The status pill turns green and shows the voter count once it is connected.

Notes:
- The anon key is designed to be public, so it is fine in a public repo. Never put the `service_role` key in this site.
- Each browser gets one ballot per category. Voting again replaces it. Someone clearing their browser data could vote again, so treat results as a fun poll, not a secure election.
- Reset one category: `delete from public.votes where category = 'blondes';`
- Reset everything: `delete from public.votes;`

## Adding a category or changing a roster

Edit `characters.js`. A new category needs a key (used in the URL and thumbnail folder), a title,
blurb, accent colours, placeholder style, and a roster that is a multiple of 5.
If you add a category and use shared voting, also add its key to the `votes_category_check`
list in `supabase.sql` and run it again.

Changing a roster resets that category's in-progress ballots automatically.
