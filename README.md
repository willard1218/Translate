# Translate

## Model

| Sentence | datatype |
|---|---|
| id | pk |
| time | datatime |
| content | string |


| Paragraph | datatype |
|---|---|
| sentences | set |

| Article | datatype |
|---|---|
| paragraphs | set |

| DiffWord | datatype |
|---|---|
| operation | int (Equal/Insert/Delete) |
| content | string |


| Quiz | datatype |
|---|---|
| problem | string |
| userAnswer | string |
| correctAnswer | string |
| diffWords | set |









