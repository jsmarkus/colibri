## Описание

![Colibri, Express, Mongoose model and MongoDB](i/drawing.png)

Colibri - это фреймворк, который упрощает задачу построения REST-сервисов для управления данными в MongoDB.

Допустим, у нас в mongodb есть коллекция статей `Articles`
и мы хотим управлять ей через REST-ресурс.

Также у нас есть веб-сервер на Express, в который мы хотим добавить наш ресурс. Допустим, это веб-сервер:

    express = require 'express'
    app = express.createServer()
    app.use express.bodyParser()
    app.use express.static "#{__dirname}/static"
    app.listen 3000

Кроме того, мы создали модель ArticleModel с помощью Mongoose:

    ArticleSchema = new mongoose.Schema
        title : String
        body  : String

    ArticleModel = mongoose.model 'Articles', ArticleSchema



Наш REST-ресурс должен обслуживать следующие запросы:

    GET /articles         - получить список статей
    POST /articles        - создать статью
    GET /articles/1234    - получить статью с _id = 1234
    PUT /articles/1234    - изменить статью с _id = 1234
    DELETE /articles/1234 - удалить статью с _id = 1234

Нас ждёт куча монотоной, кропотливой работы!
Придётся написать множество маршрутов `app.get(...)`, `app.post(...)` и т.д.,
в которых предстоит реализовать разбор запросов,
выборку сущностей, операции с ними,
обработку ошибок, и наконец, возврат результата на клиент.

Colibri упрощает эту задачу.
Вот как с его помощью строится REST-сервис:

    #создаём ресурс
    resource = colibri.createResource
        model : ArticleModel

    #с помощью ресурса создаём маршруты на сервере app
    resource.express app

Теперь у нас есть готовый бэкенд,
к которому мы можем, например, подключиться из браузера с помощью
Backbone или других клиентских библиотек, поддерживающих REST.

Пример ToDo-приложения на Backbone показан в папке examples.