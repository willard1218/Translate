# Translate

## Model


| Article | datatype |
|---|---|
| title | string |
| url | string |
| quizs | set(Quiz) |

| DiffWord | datatype |
|---|---|
| operation | int (Equal/Insert/Delete) |
| text | string |

| Quiz | datatype | note |
|---|---|---|
| question | string | english sentence |
| answer | string | chinese sentence |
| userAnswer | string | |
| diffWords | set(DiffWord) | |




