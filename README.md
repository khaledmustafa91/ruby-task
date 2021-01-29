# How this api works

This README would normally document whatever steps are necessary to get the
application up and running.

## run with that command 
Use that `docker-compose up` 

# requests about /user  

### "POST /user"
#### the user input should be like 

## Description 
user should make a post request with that json body 
to create new user and the api should return user information
and the response will be like that format

### input
post request `post /post, headers { "Content-Type": "application/json" }` 

```json
{ 
  "user": {
        "name": "Khaled",
        "email": "khaled@example.com",
        "password": "123456789",
        "image": "1.jpg" 
        }
}
```
 
### output 


```json
{
    "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJlbWFpbCI6ImtoYWxlZEBnbWFpbC5jb20iLCJwYXNzd29yZCI6IjEyMzQ1Njc4In0.-HZyS5KJyunBcDWsFZ2an0fBdFgl_8hs7kqjXSwDbg4",
    "user": {
        "id": 2,
        "name": "khaled",
        "email": "khaled@gmail.com",
        "password_digest": "$2a$12$NGSoLi1A0U/mezM/f0Ja0OH/vuvpiipywBsh74f9N6ZsoBkU.uwaG",
        "image": "1.jpg",
        "created_at": "2021-01-29T23:26:37.999Z",
        "updated_at": "2021-01-29T23:26:37.999Z"
    }
}
```
### "POST /login"

post request `post /login, headers { "Content-Type": "application/json" }` 

## Description 
user should make a post request with input json body 
to login to the api and will return token back
to use it for make any request for api

### input 

```json
{
  "user":
    {
      "email" : "khaled@gmail.com",
      "password" : "12345678"
    }
}
```
### output

```json
{
    "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJlbWFpbCI6ImtoYWxlZEBnbWFpbC5jb20iLCJwYXNzd29yZCI6IjEyMzQ1Njc4In0.-HZyS5KJyunBcDWsFZ2an0fBdFgl_8hs7kqjXSwDbg4"
}

```

### "DELETE /user"


post request `delete /user/:user_id, paramters : json body, headers { "Content-Type": "application/json" , "Authorization": "Bearer <token>"  }` 

## Description
user should make a delete request with his token 
to delete his account from the system



# requests about /post


### Post '/post/'
post request `post /post, paramters : json body, headers { "Content-Type": "application/json" , "Authorization": "Bearer <token>"  }` 

## Description
to make new post you should have your JWT token 
and all post arrtributes : title, body and tags 

### input 
```json
{
   "title":"add new post",
   "body": "restful api for blogs application",
   "tags": ["ruby" , "ruby on rails","api"]
}
```

### output 
```json
{
    "post": {
        "id": 1,
        "title": "add new post",
        "body": "restful api for blogs application",
        "tags": [
            "ruby",
            "ruby on rails",
            "api"
        ],
        "user_id": 1,
        "created_at": "2021-01-29T22:51:28.788Z",
        "updated_at": "2021-01-29T22:51:28.788Z"
    },
    "comments": []
}
```

### Patch '/post/:post_id'
post request `patch /post/:post_id, paramters : json body, headers { "Content-Type": "application/json" , "Authorization": "Bearer <token>"  }` 

## Description
to update an existing post you should have your JWT token 
and post id and updated arrtributes : title, body or tags 

### input
```json
{
   "title":"update post",
   "body": "restful api for blogs application",
   "tags": ["ruby" , "ruby on rails","api"]
}
```

```json
{
    "post": {
        "id": 1,
        "title": "update post",
        "body": "restful api for blogs application",
        "tags": [
            "ruby",
            "ruby on rails",
            "api"
        ],
        "user_id": 1,
        "created_at": "2021-01-29T22:51:28.788Z",
        "updated_at": "2021-01-29T22:51:28.788Z"
    },
    "comments": []
}
```







This site was built using [GitHub Pages](https://pages.github.com/).



* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
