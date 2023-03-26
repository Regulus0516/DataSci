library(jiebaR)
library(dplyr)

# 将中文网页的 URL 替换为你要处理的网页地址
url <- "https://www.12371.gov.cn/Item/623577.aspx"

# 从网页中读取文本内容
text <- readLines(url, encoding = "UTF-8")

# 将文本内容分词，并统计相邻的两个词组成的短语的频率
words <- jiebaR::jieba(text)
phrases <- words %>%
  mutate(next_word = lead(words)) %>%
  filter(!is.na(next_word)) %>%
  mutate(phrase = paste(word, next_word, sep = "")) %>%
  select(phrase) %>%
  count(phrase, sort = TRUE)

# 打印出出现频率最高的 10 个短语及其出现次数
head(phrases, 10)
