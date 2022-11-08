### スクレイピングでWordPressの記事のテキストを取得し、ファイルも作成するPythonスクリプト　-　本件刑事告発・非常上告事件＼金沢地方検察庁御中

:CATEGORIES: @kanazawabengosi #金沢弁護士会 @JFBAsns 日本弁護士連合会（日弁連） #法務省 @MOJ_HOUMU #参考資料


#!/usr/bin/python

"""
　WordPressの記事のテキストをURLを指定して取得。
　オプション--newで指定場所にファイルを作成
　オプション--tagsでタグを指定

　以下実行例

[~] get_text-wl-kk2022_arg.py -l http://hirono-hideki.info/kk2022/2022-10-06_174 --tags="ジャーナリストの江川紹子氏 #モトケンこと矢部善朗弁護士（京都弁護士会）"
### 「検察の汚名は一気に返上になるだろう。」というジャーナリスト清水潔氏のツイート　-　本件刑事告発・非常上告事件＼金沢地方検察庁御中

:CATEGORIES: @kanazawabengosi #金沢弁護士会 @JFBAsns 日本弁護士連合会（日弁連） #法務省 @MOJ_HOUMU #ジャーナリストの江川紹子氏 #モトケンこと矢部善朗弁護士（京都弁護士会）

- TW NOSUKE0607（清水 潔） 日時： 2022/10/04 18:27:25 URL： https://twitter.com/NOSUKE0607/status/1577228890094723072  
> 元首相亡き今、特捜部が本気で前首相を狙っているなら検察の汚名は一気に返上になるだろう。さあやれるか検察。  
>   
> 東京地検特捜部が「菅前総理」をロック・オン…ひそかに進む「重大捜査」 https://t.co/Vgjq4MRthj  
元首相亡き今、特捜部が本気で前首相を狙っているなら検察の汚名は一気に返上になるだろう。さあやれるか検察。東京地検特捜部が「菅前総理」をロック・オン…ひそかに進む「重大捜査」 https://t.co/Vgjq4MRthj— 清水 潔 (@NOSUKE0607) October 4, 2022

最終更新日時：2022-10-06_141531

[~] 
"""

from bs4 import BeautifulSoup
from html.parser import HTMLParser
from urllib.request import urlopen
import sys
import pyperclip
import datetime
import re
import argparse

#iargs = sys.argv
#base_url=args[1]

#base_url = pyperclip.paste().rstrip('\n')

parser = argparse.ArgumentParser() # 1.インスタンスの作成
parser.add_argument('-l', '--url', help="ブログ記事のURL", type=str) # 2.必要なオプションを追加
parser.add_argument('-n', '--new', help="新規に記録用ファイルを作成", type=bool) # 2.必要なオプションを追加
parser.add_argument('-t', '--tags', help="タグの設定、2つ目以降のタグは各「 #」を接頭辞", type=str)
args = parser.parse_args() # 3.オプションを解析

if not args.url:
print("ブログのURL：")
base_url = input()
else:
base_url = args.url

html = urlopen(base_url)
obj = BeautifulSoup(html, "html.parser")
data = obj.find('div', class_="entry-body")
dt_now = datetime.datetime.now()
dt_time = dt_now.strftime('%Y-%m-%d_%H%M%S')
title = obj.title.text.replace(' ', '　')
text = data.text

a = '\n+'  # １つ以上連続した改行を表す正規表現
b = '\n'   # 単一の改行
text = re.sub(a, b, text)

if not args.tags:
tags =  ":CATEGORIES: @kanazawabengosi #金沢弁護士会 @JFBAsns 日本弁護士連合会（日弁連） #法務省 @MOJ_HOUMU #参考資料"
else:
tags = ":CATEGORIES: @kanazawabengosi #金沢弁護士会 @JFBAsns 日本弁護士連合会（日弁連） #法務省 @MOJ_HOUMU #{tags}".format(tags = args.tags.rstrip('\n'))

text = """
#### {title}

{tags}

{text}

最終更新日時：{date}

""".format(title=title, text=text, date=dt_time, tags=tags)

text = text[2:-1]

print(text)

if args.new:
file_name = title.replace('　-　本件刑事告発・非常上告事件＼金沢地方検察庁御中', '')
if len(file_name) > 66:
    file_name = file_name[:66]

file_name = dt_time + '_' + file_name + '.md'
print(file_name)

path = '/home/a66/git/KK2022/wp/'
f=open(path + '/' + file_name, 'w')
f.write(text)
f.close

- スクレイピングでWordPressの記事のテキストを取得し、ファイルも作成するPythonスクリプト - 本件刑事告発・非常上告事件＼金沢地方検察庁御中 <http://hirono-hideki.info/kk2022/2022-10-06_218>

　いったん記事を保存しました。pythonの複数行のコメントアウトですが、今回初めて知ったかもしれません。3つのダブルクォーテーションで囲った範囲ですが、これまでは変数代入のヒアドキュメントで使っていました。

　本件刑事告発・非常上告事件の記録用のファイル作成になります。ようやく準備が整ったという感じです。

 昨日は手作業でファイルを作成しました。今日の2つ目がこのスクリプトで作成したファイルのファイル名になります。

```
[wp] ls     　　　　　　　　　　　　　　 14:38:43  ☁  main ☂ ⚡ ✭
2022-10-05_岡山県智頭町という海渡雄一弁護士のツイートと、「勾留百二十日」（元・大阪地検特捜部長　大坪弘道.md
2022-10-06_135448_「検察の汚名は一気に返上になるだろう。」というジャーナリスト清水潔氏のツイート.md
```



最終更新日時：2022-11-06_183517
get_text-wp-kk2022_platform.py --new True -l http://hirono-hideki.info/kk2022/2022-10-06_218
