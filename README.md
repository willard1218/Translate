# Translate

## 目的
幫助使用者練習英文翻譯

## 流程
有很多道題目 (Quizs)，每道題目都有

1. 題目(英文句子)
2. 正確答案(翻譯好的譯文)
3. 使用者答案

使用者輸入完答案時，程式會與正確答案做比對，並顯示出來哪裡不一樣。

## 資料來源
來自 Ted 的 talk，裡面有很多翻譯好的文章，並使用 [Ted-subtitle-merge](https://github.com/willard1218/Ted-subtitle-merge) parse Ted 文章，接著合併中英文字幕。

## Third-party Library
1. Diff 是使用 [google-diff-match-patch](
https://code.google.com/p/google-diff-match-patch/)，有人 [proting](https://github.com/JanX2/google-diff-match-patch-Objective-C) 到 iOS Objective-C 上。


## Model

| Article | datatype |
|---|---|
| identifier | int |
| title | string |
| url | string |
| quizs | array(Quiz) |


| Quiz | datatype | note |
|---|---|---|
| question | string | english sentence |
| answer | string | chinese sentence |
| userAnswer | string | |
| diffWords | array(DiffWord) | |



| DiffWord | datatype |
|---|---|
| operation | int (Equal/Insert/Delete) |
| text | string |

| Note | datatype |
|---|---|
| text | string |



## 設計
### Article List

顯示文章列表，分成已作答和未作答

#### 已作答完畢的文章
1. 顯示 note 數量

#### 未作答完畢的文章
1. x/y  x:目前做的題數 y:總題數

### Quiz List
#### 已作答完畢的題目
1. 顯示 note 數量

#### 未作答完畢的題目
1. 顯示 word 數量


### view
1. 要可以看歷史紀錄 複習
2. 自己打分數 看有幾句翻不好
3. 



