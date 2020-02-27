---
layout: post
title: Bootstrapping a Startup - Part 1
date: 2020-02-18 14:12 +0100
excerpt: As the co-founder of Spacebook -  A platform that connects users with any kind of space(event centres, short-let apartment, conference rooms etc) with prospective customers who are looking to use those spaces for parties, wedding ceremony, meetings or even short stay. One of my biggest challenge was how to reduce running cost mainly because we were self funded. In this article I share my Spacebook experience and the things we did to reduce running cost and get the most out of the money we are spending.
---

## TL;DR

{% marginnote 'mn-id-whatever' '**Article Outline:**<br /><br />[Introduction](#introduction)<br />[Communication](#communication)<br />Issue/Task Tracking<br />File Management <br />Money Tracking<br />Infrastructure<br />Marketing<br />Customer Management' %}

> As the co-founder of [Spacebook](https://spacebook.ng) -  A platform that connects users with any kind of space(event centres, short-let apartment, conference rooms etc) with prospective customers who are looking to use those spaces for parties, wedding ceremony, meetings or even short stay. One of my biggest challenge was how to reduce running cost mainly because we were self funded. In this article I share my [Spacebook](https://spacebook.ng) experience and the things we did to reduce running cost and get the most out of the money we are spending.

## Introduction 

If you are reading this, I assume you identified an opportunity in a market, thought about an idea, did some market research for your idea, and maybe went forward to do some SWOT analysis to match your idea with the market research you did. Now it is time to turn your idea into a product. This was me in the autumn of 2015, at the time, I had never run a business before and even worse I had never lead a team before. I break down the challenges we had as a product team into:
* Communication
* Issue/Task Tracking 
* File Management 
* Money Tracking
* Infrastructure
* Marketing
* Customer Management

To make sure this article is not too long, I will dig deeper into each challenges outlined above in more details in separate articles, outlining the challenges we faced as well as the steps we took which then led to an increase in efficiency, productivity and more importantly reducing our running cost. 

## Communication

In this section, I cover communication within the product team, communication between us and external services and communication between us and our customers. When I use the term **us** or **we**, I mean the business or people in charge or running the business.

## 1. Internal Communication

For communication within the product team which was about 5 members at the start, it wasn't difficult deciding as most of us were already familiar with Slack. For this reason we settled for using [Slack](https://slack.com/) for internal instant communication and also because it was free. While I highly recommend that you use Slack for internal communications, it would be unfair not to mention there are other free alternatives to Slack including [Chanty](https://www.chanty.com/), [Microsoft Teams](https://products.office.com/en-us/microsoft-teams/group-chat-software), [Flock](https://flock.com/), [Glip](https://glip.com/) and many more. A Google search for "Slack alternative" should give you more information about all the alternatives out there.

## 2. Communication between us and external services

As a startup, you need to sign up for all kind or services and tools. 99.9% of all services out there require you fill a form and provide an email address. We didn't have enough funds to use a service like Gmail for business which cost about $5 per user at the time and for a team of 5 people we would need in total about 7 email addresses. 

After careful cost evaluation, we settled for creating a free Gmail account. While this works, it comes with a challenge; other businesses and even customers don't take you seriously and it affect trust between you and your customer as well as other businesses because they expect you to have an email address ending with *@domain.com*.

Most shared hosting platform offer free email setup if you are managing your domain and hosting with them. In our case we weren't, our domain was managed with Cloudflare which led to the option described above. With the aforementioned challenge in mind we were looking for a free or less expensive way to all get a **@spacebook.ng** email addresses. 

After much research I came across [Mailgun](https://www.mailgun.com/) which we eventually settled for. With Mailgun, we were all able create **@spacebook.ng** email addresses and also send and receive up to 10K email messages monthly without any cost. This was later reduced to 5k{% sidenote "mailgun-pricing" "See Mailgun  pricing here [https://www.mailgun.com/pricing](https://www.mailgun.com/pricing)" %}. To be able to send and receive emails with the *@domain.com* addresses using Mailgun, there are few configurations and tricks(nothing illegal) you need to do. I will cover this in a step by step guide to sending and receiving email with Mailgun. 

## 3. Communication between us and Customers

For communication between us and our customers, we started by adding a phone number in the contact section of our website. This worked for a while but also came with it's own challenges: 
* It was not distributed because only one person could answer one customer at a time{% sidenote 'mn-id-distributed-phone-reason' 'The phone number belonged to one of us, as a result we can only attend to one customer at a time. If the person with the phone was not able to answer the call at that time then the customer would not be able to reach us and we end up incurring a cost that could have been avoided if we decide to call the customer back.' %}, 
* It was not instant and context is easily lost because the user might no longer be on our website,
* Most users would rather leave the page since calling us mean they need to spend money.

One of the biggest mistakes we made was allowing a member of the team to use their phone number as the business number. Aside from the fact that it caused contact bloat on the persons' phone, we also had an identity war, because whenever a call comes in from an unsaved number, you are not sure whether to say your name or the business name. 

We were not a registered business, so we couldn't get a registered business phone number at the time. However, what we could have done which we eventually did was:
* Get a new phone (I recommend any cheap Android phone), 
* Have one of us register a new personal phone number,
* [Truecaller](https://www.truecaller.com/) app was very popular in Nigeria at the time, we installed the app and updated the contact name to our business name so our customers who have the app installed can easily identify us.
* WhatsApp is also very popular in Nigeria, so we installed WhatsApp and created an account with the newly registered phone number so our customer could call and drop messages without spending additional money. 
* Finally, we updated the contact section of our website with the newly registered phone numbers and also added a WhatsApp icon so users were aware they can reach us on WhatsApp

The steps above didn't solve the problem of distribution, so that all or available members of the team could attend to multiple customers at once. We began to brainstorm, and eventually decided to integrate a live chat solution on the website. 

We began to research free or inexpensive live chat solutions out there. After much research and comparisons, we went with [Smartsupp](https://www.smartsupp.com) because it offers mouth watering features for free{% sidenote "smartsupp-pricing" "See Smartsupp features & pricing here [https://www.smartsupp.com/pricing#features](https://www.smartsupp.com/pricing#features)" %} including but not limited to support for 3 agents for free, mobile app for Android and IOS was available, 14-days chat history and many more.

In the coming weeks I will publish the second part of this article, going into details about Issue/Task Tracking. If you enjoyed this article or you have any clarification or you see areas of the article you think need improvements, feel free to send me an email at [hello@oshomo.oforomeh](mailto:hello@oshomo.oforomeh). 
