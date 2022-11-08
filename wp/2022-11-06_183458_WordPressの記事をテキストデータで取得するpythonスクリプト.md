### WordPressの記事をテキストデータで取得するpythonスクリプト　-　本件刑事告発・非常上告事件＼金沢地方検察庁御中

:CATEGORIES: @kanazawabengosi #金沢弁護士会 @JFBAsns 日本弁護士連合会（日弁連） #法務省 @MOJ_HOUMU #参考資料


#!/usr/bin/python

from bs4 import BeautifulSoup
from html.parser import HTMLParser
from urllib.request import urlopen
import sys
import pyperclip

#args = sys.argv
#base_url=args[1]

base_url = pyperclip.paste().rstrip('\n')

html = urlopen(base_url)
obj = BeautifulSoup(html, "html.parser")
data = obj.find('div', class_="entry-body")
print(data.text)

　「base_url = pyperclip.paste().rstrip('\n')」は、予めクリップボードにコピーしておいたブログ記事のURLになります。

　「#args = sys.argv」と「#base_url=args[1]」はコメントアウトで無効化してありますが、こちらの方を有効にするとURLを引数で受け取るので、同じURLを繰り返し使う場合にコマンドの履歴を使えます。
　編集のブロック要素は「整形済みテキスト」にしてますが、他では改行が取得できないようです。

参考サイト：  
【Python】BeautifulSoupでclassを指定して要素を取得する方法【スクレイピング】 - narupoのブログ <https://naruport.com/blog/2019/12/9/bs4-class/>



最終更新日時：2022-11-06_183458
get_text-wp-kk2022_platform.py --new True -l http://hirono-hideki.info/kk2022/2022-10-05_138
