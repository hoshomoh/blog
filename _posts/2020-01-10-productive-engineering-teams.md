---
layout: post
title: Productive Engineering Teams
date: 2020-01-10 16:21 +0100
categories: 
---

## Introduction 

Software Engineers like to build stuff (cool stuff), use new technologies, pay technical-debt, make existing solutions faster, find new ways to approach existing solutions. All this and more are what makes a software engineer pumped up and ready to go to work the following day. 

The reason we call them software engineers in the first place is because of their ability to solve simple and complex human problems with software systems by applying software engineering principles to design, develop, maintain and test software systems. 

But, in the past 4 years, I have noticed a trend with most engineering teams that hinders software engineers to do what they know how to do best thereby making them less or not productive. One of the most difficult jobs in software engineering is tracking software engineers productivity, which is even more difficult is communicating their productivity to top management and business stakeholders. This is usually the job of an engineering manager.

In simple term, it is easy to go to top management as a marketing lead and say we need to increase our marketing spend by 40% because this data shows that if we do so we can increase our conversion rate, sign up rate or even download rate etc. by so and so per cent. Now, put the same thing into the perspective of an engineering manager. How do you go to top management and say we need a new PHP backend engineer while you already have 4? cause as far as management is concerned they can't see what the existing 4 have been doing in the past 3 months. There are data points and metrics to measure engineering teams productivity and also communicate it, but, I would cover that in another series. 

## Being busy is not being productive

{% marginfigure 'mf-id-we-are-too-busy' 'assets/img/posts/being-busy.jpg' '“No thanks, we are too busy” *Image credit - Google Images*.' %}

I bet you would have seen a busy engineering team, but at the end of the week, there is nothing to show for their busyness. Don't get it twisted being busy doesn't mean being productive. 

I don't think any software engineer leaves their home in the morning with the sole purpose of coming to work to faff. For this write-up, a productive software engineer is that software engineer that spends at least about 80% or their daily work time writing software the solves users problems in a better, faster and easier way. This always involves using certain tools to:

* know which user problem has the highest priority, (See [Jira Software](https://www.atlassian.com/software/jira));
* collaborate and work with other software engineers on the same product (See [Git](https://git-scm.com/));
* test that the engineered solution solves the user problem;
* release the working tested solution to the user.

As a software engineer, after everyday work, I ask myself, was I productive today? and I can tell you for a fact that in the past 4 years I have only answered "yes" to that question 40% of the time. Below are some noticeable patterns that hinder me from being productive as a software engineer.

### 1. Meetings

Software craftsmanship requires a certain flow within a certain period during the day or night, this flow is difficult to get into, but when you get in this flow, awesome things happen. One of the easiest patterns I notice that stops me from getting into the flow or takes me out of this flow is meetings. 

And I am not talking about those meetings that are pre-planned(stand-up, refinement, retrospective and planning); I am referring to those meeting that adds no single value to your role as a software engineer. I mean those meetings someone from product asked you to join in case there is a technical question that needs to be answered. I am talking about those meetings you joined because you think you will miss out on crucial information if you don't a symptom widely known as [FOMO](https://en.wikipedia.org/wiki/Fear_of_missing_out)

I have seen companies that tell you that these meetings are not compulsory and you can choose to decline, yet the meeting tool provided as given all and sundry the ability to invite you to a meeting. What these companies don't realise is the havoc done by the noise caused by the email/push notification caused by this invite. Luckily for me, my engineering lead recently shared smart ways work around mitigate noise from emails and push notifications. I will share this with you in another blog post. Stay tuned. 

In my experience, the meetings described above is a symptom of not having technical product managers or technical team lead or engineering manager. If the product managers are not technical, then you need an engineering manager and maybe a technical team lead. The technical team lead is not always needed as a senior engineer in the team can always act in the same regard as a technical team lead. If the product managers are also technical, having an engineering manager is also highly advised. And if for any reason you already have this roles field within a team and you still see this problem at large, then one of these guys aren't doing their job.

### 2. Processes over tools

As I mentioned before, writing software that solves user problem in an easier, better and faster ways always involve using certain tools. These tools are by far the most important aspect of shipping working software/product to the user on time.  So, important that some companies even have dedicated teams that build tools to make engineers life better, some common name of such teams includes infrastructure teem, [engineering productivity team as used by Google](https://landing.google.com/engprod/). 

Now, with the level of importance these tools have, you would think all engineering teams are investing time and money into the building, buying or leasing the best tools needed for the job, but let me shock you a lot of product and engineering teams have now replaced those tools with processes. A classic and maybe very popular example is release management. Today you would think shipping tested and working software should be as easy as merging to a master branch, but let me paint two real-world scenario I have seen personally encountered. 

__Scenario 1__

Max a mid levele software engineer, picks the user story with the highest priority from the backlog, he completes the implementation in 2 days, create a pull request(PR) against a branch called test, at this stage other software engineers start reviewing the work done for the sake of quality, consistency with products coding standard and many other reasons. He gets lucky and the pull request is accepted and changes are deployed to the test environment. The quality assurance team(QA) now takes over at the stage and do some manual testing, Max gets lucky again and the implementation is accepted by the QA. Now you are probably thinking finally we are going to ship this thing to the customer, sorry to disappoint you, we are not. 

The next step is for Max to make another PR to a branch called stage which from an argument I have been made to understand is an integration branch. Luckily for Max, no code review is needed at this stage, but he still has to merge and deploy to the stage/integration environment. After which QA takes over again and do another round of testing, if all is good they give an okay to ship the changes to the customer, this makes it the 4th day since Max first interacted with the task. 

Unfortunately for Max, it's now 5 PM and release would have to wait till the following day, poor customers, I bet you also feel for the customer as much as I do. But there is hope, the release would happen the following day. Oh wait, the following day is Friday and this particular engineering teams as a no Friday release policy (😀). Well, it is what it is, they can't risk making production changes on a Friday, there is a lot of what if; what if the release fails and we need to roll back, what if the release breaks another feature and we only detect this over the weekend. Our poor customer will have to wait until Monday. 

Finally, its Monday, and we were able to release the working software to the customer. Now, looking at this scenario, you are probably thinking, this dude must have made all this up, well fellow reader, I have experienced this firsthand. Based on this scenario, below are things that should be done to improve the software engineers life and reduce the time taken to ship working software to the customer. 

* Use available tools for low-level code review. By low-level, I mean code style checks, syntax checks, etc.
* Use available tools for managing external package/dependencies update, upgrade and security. {% sidenote 'dependency-bot' 'An example is [Dependabot](https://dependabot.com/). Dependabot creates pull requests to keep your dependencies secure and up-to-date. Has support for various language and for free if you are using Github.' %}
* Invest in automated testing, be it unit tests, integration tests or even end to end tests and more importantly integrate these tests into your merge checks; one tool I personally use for this is [codecov.io](https://codecov.io).
* Use feature toggles to manage feature roll out to customers. Feature Flags have a tendency to multiply rapidly, particularly when first introduced. They are useful and cheap to create and so often a lot are created. However toggles do come with a carrying cost. {% sidenote 'feature-toggle-pete-hodgson' 'A statement from Pete Hodgson [article](https://martinfowler.com/articles/feature-toggles.html) on Feature Toggles (aka Feature Flags).' %}
* Invest heavily into logging, monitoring and alerting the right people. 

### 3. Distractions

Often have I heard the phrases, "I am more productive in the morning", "I am more productive at night", "I am more productive from home" etc. After asking myself and few other engineers, I realize one common theme with the engineers that make this comments. This engineers are either not distracted during this period, or they have less distractions during this time. 

Recent studies have shown that it takes about 30 - 45 minute to get "into the zone" and focus on the task at hand. Once distracted, it can be difficult to get back into the zone. Studies also show that it takes about 30 - 45 minutes to return to the original task. If you have 8 working hours in a day, removing compulsory and pre-planned meeting and lunch, you probably have in 6 hours in total to do real work. If you get distracted for at least 6 times during those 6 hour period you end up with having only 3 hours to do real work as the half of the time was probably spent getting back into the zone. 

I categorise distraction into two forms; direct and indirect distraction.  

__Direct Distraction__

For lack of words I decided to go with direct, direct distractions are those distractions that are primarily caused by me or those that I have 100% control over. All form of communication falls into this category, IM, slack, emails, and social media. This services or tools themselves do no harm, distraction is mostly caused by how we use them. Below are things I have tried, to reduce distractions caused by how I use this services or tools in the past. 

* Disabled mobile notifications for email, social media apps and slack. Also note that I did this on device level and not app level. 
* Created email automation to move irrelevant emails from my inbox to a separate folder and mark them to read. Irrelevant emails include, emails for update on a PR, emails for update on issues.
* Created email automation to move all calender invite from my inbox to a separate folder so I can attend to them when I want.
* Slack is such a good communication tool for work, but if you are not careful, it can be a productivity bottleneck. Thankfully, Slack has implemented different features{% sidenote 'slack-noise-cancelling-features' 'Slack keeps all your team communication in one place, but your team does a lot! [These tips](https://slack.com/intl/en-de/help/articles/218551977-Reduce-noise-in-Slack) will help you manage what gets your attention — and what does not. While [this](https://slack.com/intl/en-de/help/articles/217626558-Keep-up-with-whats-important) will help you keep up with what is important.'%} to put you in charge of how you consume information.

__Indirect Distraction__

### 4. Poorly refined tasks
