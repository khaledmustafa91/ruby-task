# How this API works

This README would normally document whatever steps are necessary to get the
application up and running.

# Run that command to run API
Use that `docker-compose up` 

# Requests about /user (user API)

### "POST /user"

post request `post '/user', parameters: {json body}, headers { "Content-Type": "application/json" }` 

## Description 
User should make a post request with input json body 
to create new user and the api should return user information
and the response will be like that output format

### Input
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
 
### Output 
```json
{
    "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJlbWFpbCI6ImtoYWxlZEBnbWFpbC5jb20iLCJwYXNzd29yZCI6IjEyMzQ1Njc4In0.-HZyS5KJyunBcDWsFZ2an0fBdFgl_8hs7kqjXSwDbg4",
    "user": {
        "id": 1,
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

post request `post '/login', paramters: {json body}, headers { "Content-Type": "application/json" }` 

## Description 
User should make a post request with input json body 
to login to the api and will return token back
to use it for make any request for api

### Input 
```json
{
  "user":
    {
      "email" : "khaled@gmail.com",
      "password" : "12345678"
    }
}
```
### Output
```json
{
    "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJlbWFpbCI6ImtoYWxlZEBnbWFpbC5jb20iLCJwYXNzd29yZCI6IjEyMzQ1Njc4In0.-HZyS5KJyunBcDWsFZ2an0fBdFgl_8hs7kqjXSwDbg4"
}

```

### "DELETE /user"

delete request `delete '/user/:user_id', headers { "Content-Type": "application/json" , "Authorization": "Bearer <user_token>"  }` 

## Description
User should make a delete request with his token 
to delete his account from the system



# Requests about "/post" (Post API)


### Post '/post'

post request `post '/post', paramters: {json body}, headers { "Content-Type": "application/json" , "Authorization": "Bearer <user_token>"  }` 

## Description
To make new post you should have your JWT token 
and all post arrtributes: title, body and tags 

### Input 
```json
{
   "title":"add new post",
   "body": "restful api for blogs application",
   "tags": ["ruby" , "ruby on rails","api"]
}
```

### Output 
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

patch request `patch '/post/:post_id', paramters: {json body}, headers { "Content-Type": "application/json" , "Authorization": "Bearer <user_token>"  }` 

## Description
To update an existing post you should have your JWT token
,post id and updated arrtributes: title, body or tags
#### Note 
If you not owner of that post api won't allow to you 
update that post 

### Input
```json
{
   "title":"update post",
   "body": "restful api for blogs application",
   "tags": ["ruby" , "ruby on rails","api"]
}
```

### Output
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

### Get '/post/:post_id'

get request `get '/post/:post_id', headers { "Content-Type": "application/json" , "Authorization": "Bearer <user_token>"  }` 

## Description
To get an existing post you should have your JWT token
and post id

### Output
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


### Delete '/post/:post_id'

delete request `delete '/post/:post_id', headers { "Content-Type": "application/json" , "Authorization": "Bearer <user_token>"  }` 

## Description
To delete an existing post you should have your JWT token
and post id
#### Note 
If you not owner of that post api won't allow to you 
delete that post 

### output
status code : 200 OK





# Requests about "/post/:post_id/comment" (Comment Api)


### Post '/post/:post_id/comment'

post request `post '/post/:post_id/comment', paramters : {json body}, headers { "Content-Type": "application/json" , "Authorization": "Bearer <user_token>"  }` 

## Description
To make new comment on a post you should have your JWT token 
and all comment arrtributes: body 

### Input 
```json
{
   "body": "restful api for blogs application",
}
```

### Output 
```json
{
    "id": 1,
    "body": "restful api for blogs application",
    "user_id": 1,
    "post_id": 1,
    "created_at": "2021-01-29T22:52:06.341Z",
    "updated_at": "2021-01-29T22:52:06.341Z"
}
```

### Patch '/post/:post_id/comment/:comment_id'

patch request `patch '/post/:post_id/comment/:comment_id', paramters : {json body}, headers { "Content-Type": "application/json" , "Authorization": "Bearer <user_token>"  }` 

## Description
To update an existing comment on a post you should have your JWT token, 
post id, comment id and updated arrtributes: body
#### Note 
If you are not owner of that comment api won't allow to you 
update that comment 

### Input
```json
{
   "body": "update restful api for blogs application",
}
```

### Output
```json
{
    "id": 1,
    "body": "update restful api for blogs application",
    "user_id": 1,
    "post_id": 1,
    "created_at": "2021-01-29T22:52:06.341Z",
    "updated_at": "2021-01-29T22:52:06.341Z"
}
```

### Get '/post/:post_id/comment/:comment_id'

get request `get '/post/:post_id/comment/:comment_id', headers { "Content-Type": "application/json" , "Authorization": "Bearer <user_token>"  }` 

## Description
To get an existing comment you should have your JWT token
,post id and comment id

### Output
```json
{
    "id": 1,
    "body": "restful api for blogs application",
    "user_id": 1,
    "post_id": 1,
    "created_at": "2021-01-29T22:52:06.341Z",
    "updated_at": "2021-01-29T22:52:06.341Z"
}
```


### Delete '/post/:post_id/comment/:comment_id'

delete request `delete '/post/:post_id/comment/:comment_id', headers { "Content-Type": "application/json" , "Authorization": "Bearer <user_token>"  }` 

## Description
To delete an existing comment you should have your JWT token,
post id and comment id
#### Note 
If you not owner of that comment api won't allow to you 
delete that comment 

### output
status code : 200 OK




## Some validation errors 


- If you try to create new user and password less than 8 characters or invalid email 
  - **Error Message will be like that**
    - ```json  
        {
            "email": [
                "is invalid"
            ],
            "password": [
                "is too short (minimum is 8 characters)"
            ]
        }
       ```
- If you try to create a new post with missing arrtributes 
  - **Error Message will be like that**
    - ```json
            {
                "message": {
                    "title": [
                         "can't be blank"
                        ]
               }
             }
      ```
- If you try to create a new comment with empty body
  - **Error Message will be like that**
    - ```json 
            {
                "message": {
                        "body": [
                            "can't be blank"
                        ]
                }
            }
       ```
## Example of post have some comments 


```json
{
    "post": {
        "id": 1,
        "title": "blog api",
        "body": "restful api for books application",
        "tags": [
            "ruby",
            "ruby on rails",
            "api"
        ],
        "user_id": 1,
        "created_at": "2021-01-29T22:51:28.788Z",
        "updated_at": "2021-01-29T22:51:28.788Z"
    },
    "comments": [
        {
            "id": 1,
            "body": "that is useful api",
            "user_id": 2,
            "post_id": 1,
            "created_at": "2021-01-29T22:52:06.341Z",
            "updated_at": "2021-01-29T22:52:06.341Z"
        }
    ]
}
```
