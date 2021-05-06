---
layout: post
title: Accessing Laravel request properties dynamically a no-no
date: 2020-09-14 12:36 +0300
categories: 
excerpt: Laravel offers multiple ways for accessing request properties including using dynamic properties, this
 article focuses on why you shouldn't use dynamic properties and offer other available methods for all kind of
  scenarios. 
image: 
---

Laravel offers multiple ways of accessing request properties. You can browse through the official
 [documentation](https://laravel.com/docs/8.x/requests) for a full list of the available methods. 

One and very popular way for accessing request properties is via `Dynamic Properties`. According to the Laravel
 documentation, this is what happens internally when you use dynamic properties:

{% epigraph "When using dynamic properties, Laravel will first look for the parameter's value in the request payload. If it is not present, Laravel will search for the field in the route parameters.
" "Laravel" "[Version 8.x]" %}

While this is a very powerful feature I do not recommend developer use it for the following reasons:

### 1.Same property in input and route parameters

The same property might exist in both the route parameters and the input parameters. For example take the request below:

```php
$name = $request->name;
```

If you meant to access the `name` from the route parameter then `$name` would be incorrect since laravel would return the value from the input parameters.


### 2. Less intuitive

When I am reading through a codebase, I like to look at a variable and immediately guess where the value is coming from
. With the usage of `dynamic properties`, this makes that impossible, thus making the code more difficult to understand
 at first look.

Laravel offers other more intuitive methods for accessing request properties for all kind of scenarios without
 having to use `dynamic properties` such that when another developer is reading through your codebase, they can
  immediately guess where a variable is coming from. See table below: 
  
<br>

| Scenario | Available Method |
|:----------------|:----|
| From Body | **$request->input** |
| From Query String | **$request->query** |
| From Cookie | **$request->cookie** |
| From File Upload | **$request->file** |
| From Route | **$request->route** |


### What of `$request->get`?

`$request->get` works because the method belongs to `Symfony HttpFoundation` and is not usually needed when using
 Laravel. In fact, there is no mention of it within the Laravel documentation, so if I where you I will stay away
  from, `$request->get`.
 
Another reason you should use `$request->input` over `$request->get` is because `$request->input` is more powerful
 and can be used with array/JSON inputs by using "dot" notation to access the array or JSON properties like below:
 
 ```php
$name = $request->input('products.0.name');

$names = $request->input('products.*.name');
 ```

### Why is `$request->route` not documented?

Actually it is indirectly documented in the [route section](https://laravel.com/docs/8.x/routing). You can access the
 current route using `$request->route` and this can also be used to access the route parameters like so:
 
```php
$userId = $request->route('user_id');
 
// With Default Value
$names = $request->route('user_id', '1');
```

Laravel supports dependency injection for route parameters, so if you are a fan of [route model binding](https
://laravel.com/docs/8.x/routing#route-model-binding) like me then you should consider using parameter injection
 instead of `$request->route`. As an example, say you have a route as defined below:
 
```php
Route::put('user/{id}', [UserController::class, 'update']);
```

You may still type-hint the `Illuminate\Http\Request` and access your route parameter `{id}` by defining your controller method as follows:

```php
public function update(Request $request, $id)
{
    //
}
```




 
