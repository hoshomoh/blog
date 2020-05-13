---
layout: post
title: BDD with CodeceptJS
date: 2020-03-25 14:12 +0100
excerpt: BDD (Behavior-driven development) is an Agile software development process that bridges the gap between business participants, quality assurance engineers and developer by encouraging collaboration across these roles with a shared understanding of the problem to be solved. BDD doesn’t aim to replace business or testing process but augment it. Which is why it imperative to understand that not every test cases should be described as BDD features. In this article, I will show you how to set up BDD with CodeceptJS.
---

## Introduction 

BDD (Behavior-driven development) is an Agile software development process that bridges the gap between business participants, quality assurance engineers and developer by encouraging collaboration across these roles with a shared understanding of the problem to be solved. BDD doesn’t aim to replace business or testing process but augment it. Which is why it imperative to understand that not every test cases should be described as BDD features. In this article, I will show you how to set up BDD with CodeceptJS.

## Setting up CodeceptJS

We start with an empty project. I will call mine `codecept-bdd-sample`. Open up your favourite terminal, mine is iTerm2 and initialize npm:

```shell
npm init -y
```

I have chosen to use Puppeteer with CodeceptJS. Feel free to use any of the supported helpers.

```shell
npm install codeceptjs puppeteer --save-dev
```

Initialize CodeceptJS in the current directory by running the command below. You will be asked a couple of questions, press return/enter for all questions. When you are asked to select a helper choose **Puppeteer**.

```shell
npx codeceptjs init
```

## Enable Gherkin

Enabling Gherkin for your CodeceptJS project is as easy as running the command below:

```shell
npx codeceptjs gherkin:init
```

This command will add a gherkin section to the `codecept.conf.js` file. It will also prepare directories for the BDD features and step definitions as well as create the first feature file for you. By default, the step definitions folder is `step_definitions` while the features' folder is `features`.

I like to leave things this way but, feel free to rename them to whatever suits you. If you do rename them, remember to update the `codecept.conf.js` file. 

## Gherkin Keywords

Gherkin has sets of supported keywords that can be used in our feature files. Not all of them are supported by CodeceptJs. We would examine those supported in CodeceptJS in more details.

The primary keywords are:

- Feature
- Scenario
- Given, When, Then, And
- Background
- Scenario Outline (or Scenario Template)
- Examples

There are a few secondary keywords as well:

- <span>""" (Doc Strings)</span>
- <span>| (Data Tables)</span>

### Feature

The purpose of the `Feature` keyword is to provide a high-level description of a software feature and to group related scenarios.

The first primary keyword in a Gherkin document must be `Feature`, followed by a `:` and a short text that describes the feature.

Replace the content of `basic.feature` with the content below:

```gherkin
Feature: Setting up CodeceptJS 
    This is a good description of the feature 
    and has no meaning to the test runner. 
    Just a good way of providing documentation.
    The description ends when we start a new line 
    with the keyword Background, Rule, Example 
    or Scenario Outline (or their alias keywords).
```

### Scenario

`Scenario` describes a concrete example that illustrates a business rule. It consists of a list of steps. `Scenario` consists of steps using the `Given`, `When`, `Then`, & `And` keywords.
 
You can have as many steps as you like, but it is recommended to keep the number at 3-5 so, the scenario doesn't lose its expressive power as a specification and documentation.

We would add our first scenario to the `basic.feature` so, the file should contain:

```gherkin
Feature: Setting up CodeceptJS 
    This is a good description of the feature 
    and has no meaning to the test runner.

    Scenario: Initialize npm
      Given I am trying to initialize npm
      When I run the command npm init -y
      Then a package.json file must be generated
```

Update the step definitions file{% sidenote 'step-definition-file-update' 'You must always update the step definitions file every time you make changes to any of the feature file.' %} with the command below:

```shell
npx codeceptjs gherkin:snippets
```

This will produce code templates for all undefined steps in the .feature files. By default, it will scan all the .feature files specified in the gherkin.features section of the `codecept.conf.js` file and produce code templates for all undefined steps. 

The generated code template will be written in the first file of the gherkin.steps array in our `codecept.conf.js` file which in our case will be `'./step_definitions/steps.js'`.
 
 I don't like this approach because this would mean step definition templates for all features will be written in the same file. The more feature files I add the longer the steps definition file will become. 
 
 This is also the reason why CodeceptJS provided the option to specify which feature file you want to scan and where you want the steps' definition templates to be written. Passing `--feature` option to the command above will make sure only the specified file will be scanned, while passing `--path` option will write the generated code template to the specified file.{% sidenote 'step-definition-file-in-config' 'Before you pass a step file with the `--path` option, the step should already be added to the gherkin.steps array in your `codecept.conf.js`.' %} 

Let's see it in action. Start by creating a new step file in the `step_definitions` folder for the basic feature. I will call mine `basic.steps.js`. Then, update the gherkin.steps array in my `codecept.conf.js` file, so it looks like:

```
steps: [
    './step_definitions/steps.js',
    './step_definitions/basic.steps.js'
]
```

We can now re-run the snippet command with the `--feature` and `--path` option with the command below:

```shell
npx codeceptjs gherkin:snippets --feature ./features/basic.feature --path ./step_definitions/basic.steps.js
```

I am sure you agree that the command is quite long, plus we must always manually create a steps' definition file for every feature file as well as remember to update the gherkin.steps array in our `codecept.conf.js`.
 
I don't have the patience to keep repeating these steps, plus I won't remember the step nor the command. So, I created a [package](https://www.npmjs.com/package/codecept-cli) for doing just that. 

### Given

`Given` steps describe the initial state of the system - the scene of the scenario. It is typically something that happened or something that needs to happen before the user starts interacting with the system. Think of opening a page, initializing a database, creating a folder etc.
 
Examining the `Given` step `I am trying to initialize npm` of our `Scenario` above, this is where would create our project folder and `cd` into the folder so, we can run the initialization command.
 
It is absolutely okay to have more than one `Given` step in your scenario, you can, however, make it more readable by using `Given` with `And`.

Other Examples:

```gherkin
# ========= Example 1 =========
Given I am on the checkout page

# ========= Example 2 =========
Given I am on the landing page
Given I am logged in

# More readable with And. So we change to:
Given I am on the landing page
And I am logged in

# ========= Example 3 =========
Given Max Mustermann has a balance of £42 
```

### When

`When` step describes an event or an action performed by a person(think product persona) interacting with the system, or it can be an event triggered by another system.

It’s strongly recommended to only have a one `When` per `Scenario`. If you see yourself adding more than one `When` per `Scenario`, then that is a big red flag you need to split that scenario into multiple scenarios.

Examining the `When` step `I run the command npm init -y` of our `Scenario` above, the person here is me while the action is running the command `npm init -y`. 

Other Examples:

 ```gherkin
# ========= Example 1 =========
When I click on the booking button
 
# ========= Example 2 =========
When I open the checkout page

# ========= Example 3 =========
When Max Mustermann adds £20 his account
 ```

### Then

`Then` steps describe an expected outcome or result. This is where we would normally do an assertion that the action performed with the `When` step yield the expected outcome.

Just like the `Given` step, it is also okay to have more than one `Then` step in your scenario, you can, however, make it more readable by using `Then` with `And`.

Examining the `Then` step `a package.json file must be generated` of our `Scenario` above, this is where we check for the existence of the package.json file.

Other Examples:

 ```gherkin
# ========= Example 1 =========
Then I should see something
 
# ========= Example 2 =========
Then I shouldn't see something 

# ========= Example 3 =========
Then Max Mustermann should see a new balance
Then Max Mustermann balance should be £60
Then Max Mustermann should not see the old balance

# More readable with And. So we change to:
Then Max Mustermann should see a new balance
And Max Mustermann balance should be £60
And Max Mustermann should not see the old balance
 ```

### And

As described in the `Given` and `Then` section, `And` step can be used for making successive `Given` and `Then` more fluidly structured and readable.

### Background

Sometimes you find yourself repeating the same steps for the scenarios in a `Feature`. This is the reason for the `Background` step. It behaves like the CodeceptJS `Before Hook`, however, try not to confuse it as being a replacement for the `Before Hook` as CodeceptJS allow you to specify `Before` and `After` Hooks for all your steps file.

Example:

 ```gherkin
Feature: Adding product to cart
  Adding product to cart feature description
 
  Scenario: Redirecting to product listing page
    Given I am a logged in user
    And I am on the landing page
    When I click on the product listing page link
    Then I should be redirected to the product listing page

  Scenario: Showing image in a Modal
    Given I am a logged in user
    And I am on the landing page
    When I click on an image in the image gallery
    Then The clicked image should be displayed in a full screen Modal

# Notice how Given & And step of both scenarios are the same?
# Instead of having duplicated steps in both scenario, we can 
# solve the duplication by using the Background step like below:

Feature: Adding product to cart
  Adding product to cart feature description

  Background:
    Given I am a logged in user
    And I am on the landing page
 
  Scenario: Redirecting to product listing page
    When I click on the product listing page link
    Then I should be redirected to the product listing page

  Scenario: Showing image in a Modal
    When I click on an image in the image gallery
    Then The clicked image should be displayed in a full screen Modal
 ```

### Scenario Outline

The `Scenario Outline`{% sidenote 'no-support-for-scenario-outline' 'As at the time of writing this post, CodeceptJS does not automatically generate the stub template definition for a *Scenario Outline* so, you have to manually add the step definitions yourself.' %} keyword can be used to run the same `Scenario` multiple times, with different combinations of values. Think of it like what you already know as [Data Driven Test](https://codecept.io/advanced/#data-driven-tests) in CodeceptJS. The keyword `Scenario Template` is a synonym of the keyword `Scenario Outline` so, feel free to use them interchangeably.

Take the example below, you will see how repetitive the scenarios become, with the total number of fruits, number of fruits eaten, and the number of fruits left as the only changing values.

 ```gherkin
Feature: Eating fruits
  We can eat different kind of fruits
 
  Scenario: eat 5 out of 12
    Given there are 12 apples
    When I eat 5 apples
    Then I should have 7 apples left
  
  Scenario: eat 5 out of 20
    Given there are 20 apples
    When I eat 5 apples
    Then I should have 15 apples left
 ```

We can collapse these two similar scenarios into a `Scenario Outline` by replacing the changing values with a template delimited with `< >` and passing the changing values in form of a table using the `Examples` keyword. The table header should match the template used in the scenario. 

Revising the initial example above using `Scenario Outline`:

 ```gherkin
# Notice how the template <total>, <eat> and <left> 
# matches the table header in the `Examples` keyword.
Feature: Eating fruits
  We can eat different kind of fruits
 
  Scenario Outline: remainder after eating
    Given there are <total> apples
    When I eat <eat> apples
    Then I should have <left> apples left

    Examples:
      | total | eat | left |
      |    12 |   5 |    7 |
      |    20 |   5 |   15 |
 ```

## Passing parameters to step definitions

In some cases, you might want to pass data to steps definition functions from your feature file. Take the feature below as an example:

 ```gherkin
Feature: checkout process
  Buying order to buy products

  Scenario:
    Given I have product with $600 price in my cart
    When I go to checkout process
    Then I should see that total number of products is 2
 ```

Running the CodeceptJS snippet command will generate the snippet below:

 ```js
Given('I have product with $600 price in my cart', () => {
    // From "features/basic.feature" {"line":5,"column":5}
    throw new Error('Not implemented yet');
});

When('I go to checkout process', () => {
    // From "features/basic.feature" {"line":6,"column":5}
    throw new Error('Not implemented yet');
});

Then('I should see that total number of products is 2', () => {
    // From "features/basic.feature" {"line":7,"column":5}
    throw new Error('Not implemented yet');
});
 ```

While the above seems fine, the problem is the `$600` from the `Given` step & the `2` in the `Then` step will not be passed to the respective step function. There are different ways of resolving this so that data from the feature definition can be used in the step function.

1. Using Regular Expressions:
2. Using Cucumber Expressions
3. Using Doc Strings
4. Using Data Tables

### Using Regular Expressions

We would change the step definition’s expression to be a Regular Expression. The Regular Expression much match the step defined in the feature file. Using the `Given` step definition defined above as `Given I have product with $600 price in my cart`, updating the generated step definition using Regular Expressions will look like:

 ```js
Given(/I have product with \$(\d+) price in my cart/, (price) => {
    // From "features/basic.feature" {"line":5,"column":5}
    console.log(price);
    throw new Error('Not implemented yet');
});
```

`(\d+)` will be passed as a parameter to the step function. The parameters will be passed according to when they appear in the expression, `(\d+)` being the first parameter found in the expression will be the first to be passed to the function. 

The parameters don't have names, so feel free to access them with any name you see fit. In my example I have chosen to use `price` but, I could as well change it to `parameter1`.

### Using Cucumber Expressions

Cucumber Expressions offer similar functionality to Regular Expressions, with a syntax that is easier to read and write. My personal preference is to use Cucumber Expressions. Using the `Then` step definition defined above as `Then I should see that total number of products is 2`, updating the generated step function using Cucumber Expressions will look like: 

 ```js
Then('I should see that total number of products is {int}', (totalProduct) => {
    // From "features/basic.feature" {"line":7,"column":5}
    console.log(totalProduct);
    throw new Error('Not implemented yet');
});
```

Just like the Regular Expressions, the parameters will be passed according to when they appear in the expression. I also chose to use `totalProduct` as the variable name for accessing the first parameter, you can change this to whatever you like. 

The following are built-in parameter types that can be used with Cucumber Expressions. `{int}`, `{float}`, `{word}`, `{string}` and `{}`.

| Parameter | Description |
|:----------------|:----|
| **{int}** | Matches integers, for example **71** or **-19**. |
| **{float}** | Matches floats, for example **3.6**, **.8** or **-9.2**. |
| **{word}** | Matches words without whitespace, for example **banana** (but not **banana split**) |
| **{string}** | Matches single-quoted or double-quoted strings, for example **"banana split"** or **'banana split'** (but not **banana split**). Only the text between the quotes will be extracted. The quotes themselves are discarded. Empty pairs of quotes are valid and will be matched and passed to step code as empty strings. |
| **{}** | Matches anything (**/.*/**). |

CodeceptJS will automatically convert double-quoted strings to Cucumber Expressions. For example, the generated step function for this => `Given I have 2 "apples" and 4 "tomatoes"` will look like:

 ```js
Given('I have 2 {string} and 4 {string}', (fruit, vegetable) => {
    console.log(fruit, vegetable);
});
```

As you can see, I am accessing both parameters using `fruit` and `vegetable`, which could also be changed to `parameter1` and `parameter2`. `fruit` will be equal to `apples` while `vegetable` will be equals to `tomatoes` when the test runs.

You can do much more with Cucumber Expressions, check the [official documentation](https://cucumber.io/docs/cucumber/cucumber-expressions/) for other possibilities not covered in this article.

### Using Doc Strings

`Doc Strings` is handy for passing larger pieces of text that would not fit into a `{word}`, `{string}` or `{}`. Unlike `{int}`, `{float}`, `{word}`, `{string}` and `{}` there is no need for you to match the `Doc Strings` to a parameter in the step definition. This will be automatically passed as the last parameter of the step function and can be accessed with the `content` property of the last parameter. 

Example:

 ```gherkin
Feature: blog posts
  Creating a new blog post

  Scenario:
      Given a blog post named "My first post" with body
        """
        Here is the first paragraph of my blog post. Lorem ipsum dolor sit amet,
        consectetur adipiscing elit.
        """
 ```

The indentation of the `"""` is not very important, but I prefer to indent two spaces after the enclosing step, the indentation inside the `"""` is however important, because it behaves like the Javascript ES6 template literal and preserves the content as it was written in the `Doc Strings`.

The generated step definition for the example feature above will look like:

 ```js
Given('a blog post named {string} with body', (postName, docString) => {
  console.log(postName, docString.content)
});
```

Remember that the `Doc Strings` is passed as the last parameter, and the value can be accessed from the `content` property, which is why I logged `docString.content`.

### Using Data Tables

`Data Tables` are perfect for passing a list/array into a step function. So, instead of repeating a step with different values, we can pass those values as a list and iterate over them in our step function.

 ```gherkin
# Instead of doing
Scenario:
  Given the user with email "max@example.com" and twitter profile "@maxM" exists
  And the user with email "steff@example.com" and twitter profile "@steff" exists
  And the user with email "greg@example.com" and twitter profile "@greg" exists
  And the user with email "jonathan@example.com" and twitter profile "@jonathan" exists

# We could use Data Tables to avoid step repetition by doing:
Scenario:
  Given user with email and twitter username exists
    | email | twitter |
    | max@example.com | maxM |
    | steff@example.com | steff |
    | greg@example.com | greg |
    | jonathan@example.com | jonathan |
 ```

Just like `Doc Strings`, `Data Tables` will be the last parameter passed to the step function. So the step definition for the scenario above will look something like:

 ```js
Given('user with email and twitter username exists', (dataTable) => {
    const tableByHeader = dataTable.parse().hashes();
    // Iterate through the table to access its values
    for (const row in tableByHeader) {
        // Take the respective values 
        const email = row.email;
        const twitter = row.twitter;
        // ...
    }
});
```

CodeceptJS allows you to parse the table using `hashes` as we saw above and two other methods:

- **raw()** - returns the table as a 2-D array
- **rows()** - returns the table as a 2-D array, without the first row
- **hashes()** - returns an array of objects where each row converted to an object (column header is the key)

## Finally 

The four methods outlined above for passing data from the feature file to step function can be used with any of the step keyword `Given`, `Then`, `When` etc. 

CodeceptJS supports `Before`, `After` and `Fail` Hooks in the step definition files. 

The `Before` Hook runs before any of the Scenario, it takes the current test as a parameter and is the best place to manage state between Scenarios or do general test configuration.

Example:

 ```js
let state = {};

Before((test) => {
    state = {};
    test.retries(2); // retry scenarios 2 times
});

Given('the user is logged in', async () => {
    state.user = await someLoginFuntion();
});

Then('the logged in user is Oshomo', () => {
    assertEquals('Oshomo', state.user.name);
})
```

The `After` Hook runs after all the Scenarios, this is the best place to do general garbage collection or in simple terms clean up.

Example:

 ```js
After(async () => {
    delete someData;
    await someService.cleanup();
});
```

The `Fail` Hook run when any of the Scenario fails and receives two parameters, the current `test` and the current `error`. 

Example:

 ```js
Fail((test, error) => {
    console.log('An error has occurred - ', error);
});
```
 
Note that not all tests should be defined as BDD features, as such you might have generic acceptance tests, and a minimal set of BDD Scenarios for your key business values. By default, CodeceptJS will run both your BDD Scenarios and general acceptance tests with the command `npx codeceptjs run`, the BDD Scenarios runs first. You can tell CodeceptJS to run only the general acceptance tests by appending `--tests` to the command or run only the BDD Scenarios by appending `--features` to the command.

If you are new to BDD, I strongly recommend reading the following articles:

- Introducing BDD by Dan North. [https://dannorth.net/introducing-bdd/](https://dannorth.net/introducing-bdd/)
- Behaviour-Driven Development by Cucumber. [https://cucumber.io/docs/bdd/](https://cucumber.io/docs/bdd/)
- Behaviour-Driven Development by Wikipedia. [https://www.wikiwand.com/en/Behavior-driven_development](https://www.wikiwand.com/en/Behavior-driven_development)








