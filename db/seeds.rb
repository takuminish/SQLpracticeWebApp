# coding: utf-8

Problem.create!(title: "全てのデータを表示しよう", statement: "Bookテーブルの全てのデータを表示しよう", answer: "SELECT * FROM books", level: 1)
Problem.create!(title: "titleとauthorだけを表示しよう", statement: "Bookテーブルのtitleとstatementのデータを表示しよう", answer: "SELECT title, author FROM books", level: 1)

5.times do |i|
  Book.create!(title: "犬について(#{i})", author: "John K", price: 1300, page_num: 120)
end
