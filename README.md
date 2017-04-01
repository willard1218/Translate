# Translate

## Model

| Sentence | datatype |
|---|---|
| time | datatime |
| content | string |


| Paragraph | datatype |
|---|---|
| sentences | set(Sentence) |
| quiz | Quiz |

| Article | datatype |
|---|---|
| paragraphs | set(Paragraph) |

| DiffWord | datatype |
|---|---|
| operation | int (Equal/Insert/Delete) |
| content | string |


| Quiz | datatype |
|---|---|
| problem | Paragraph |
| userAnswer | string |
| correctAnswer | string |
| diffWords | set(DiffWord) |




