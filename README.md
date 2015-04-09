# Wordcounter

This app take input from either pasted text or a PDF, strips and de-conjugates the words of the text, and returns the 25 most frequent words.

The app is written on Rails and is hosted on Heroku.

The app breaks the text down into individual words using regex matching. It then compares the word to a list of known common english conjucations. If the word matches one of these conjugations, the base form is added to the list of frequencies. If it does not match, the suffixes are stripped from the word. The word is then added to the frequencie table.

This app has one dependency to handle PDF reading: pdf-reader. Adapters for Postgres and Sqlite3 are included because Rails and Heroku require that a DB adapter be present; this app does not access the database at all.
