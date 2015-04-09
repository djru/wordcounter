# [Wordcounter](http://wordcountr.herokuapp.com)

This app take input from either pasted text or a PDF, strips and de-conjugates the words of the text, and returns the 25 most frequent words.

The app is written on Rails and is hosted on Heroku.

The app breaks the text down into individual words using regex matching. It then compares the word to a list of known common english conjucations. If the word matches one of these conjugations, the base form is added to the list of frequencies. If it does not match, the suffixes are stripped from the word. The word is then added to the frequencie table.

This app has one dependency to handle PDF reading: pdf-reader. Adapters for Postgres and Sqlite3 are included because Rails and Heroku require that a DB adapter be present; this app does not access the database at all.

## Limitations 

The app is running on the free Heroku tier and has only one worker to compute everything and handle serving pages. Queing and parallelization have not been implemented for two reasons: time constraints and cost. Beacuse of this, the app is fairly slow for texts over a few thousand words, and cannot handle large texts at all. With more time and money to spend on hosting, the app could be sped up substantially.

Additionally, there are invariably going to be edge cases that are not met. In testing, these cases seemed to be minimal and rare, since most pieces of text share a set of the same common english words (words like is, the, can, etc.) However, examples can be contrived to produce errors in the analysis. One way of getting around this would be to drastically expand the dictionary of irregular conjugations as they arrise. However, after a certain point the dictionary would get too large to store in memory, and would have to be offloaded to a database. This would take time and drastically slow the app down since DB transactions tend to be slower than reading from a native Ruby object. 

The app can be found [here](http://wordcountr.herokuapp.com).
