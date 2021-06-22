---
layout: post
title: Using Context API in React
excerpt: The context API offers us a clean and re-usable way of passing down global
  variables across all out components. In this tutorial, I show you how to create
  and consume a context in a class and functional component.
image: 
date: 2021-05-31 11:18 -0500
---

{% marginnote 'mn-id-whatever' '**Article Outline:**<br /><br />[Creating Context](#creating-context)<br />
[Providing Context](#providing-context)<br />[Consuming Context](#consuming-context)<br />
[Updating Context](#updating-context) <br />[Conclusion](#conclusion)' %}

Data is often passed to react components using props, whether as a single component or components with one or more 
children components. This can be very cumbersome for global variables or properties like current logged-in user, 
user locale, theme etc. React context provide us with an API to pass data across all components without having to 
pass props from grand-parent to parent and then to child. 

Often I see people try to use a state container like Redux to solve this problem but then end up with a more complex 
solution of creating a store, initial state and then passing state value down to components using `mapStateToProps`.

The context API offers us a clean and re-usable way of passing down global variables across all out components.

## Creating Context

Say we wanted to create a global context for handling currently authenticated user. We start by creating a file 
named `UserContext.js` with the content below:

 ```tsx
import React from 'react';

const UserContext = React.createContext(null);

export const UserProvider = UserContext.Provider;
export const UserConsumer = UserContext.Consumer;

export default UserContext;
```

The code above create a React context named `UserContext` and this also gives us a `Provider` and a `Consumer`. 
`Provider` as the name implies is the component that provides the value to be used by other component while 
`Consumer` is a component consuming or rather using this value. 

`React.createContext` takes a `defaultValue` which as you can see above in our case I have set to `null`. The 
`defaultValue` is only used when the `Consumer` can not find a matching `Provider` above the component tree. This is 
mostly useful during testing when you don't want to wrap your components in a `Provider`. Passing `undefined` as the
`defaultValue` does not cause the consuming components to use this value. 

## Providing Context

No matter how you choose to consume a context value, the context `Provider` must always be a parent of the 
components consuming the context value. The `Provider` takes `value` as props and this value is passed down to all 
descendent components that subscribe to the context value via a `Consumer`.

 ```tsx
import React from 'react';
import Home from './Home';
import { UserProvider } from './UserContext';

function App() {
  const user = { name: 'Oshomo Oforomeh' };

  return (
    <UserProvider value={{ user }}>
      <Home />
    </UserProvider>
  )
}
```

Now the user `value` will ve available to the `HomePage` component and its children, grand-children and 
great-grand-children. You need to be careful how you update and manage the `Provider` value, because a change to the 
`value` will cause a re-render of all the components consuming the `Provider` value.

## Consuming Context

Unlike the `Provider` the way you consume a context is not the same for class and functional components. I will show 
you how to use the `Consumer` to subscribe to a context and access the `Provider` value.

### Class Components

The easiest way to consume a context in a class component is to use the static `contextType` property on the class. 
Using this property let you consume the nearest context `Provider` value using `this.context`. `this.context` can be 
used in all component lifecycle including the `render` method.

```tsx
import React from 'react';
import UserContext from './UserContext';

class Home extends React.Component {
  static contextType = UserContext;

  componentDidMount() {
    const { user } = this.context;
    console.log(user); // { name: 'Oshomo Oforomeh' }
  }

  render() {
    const { user } = this.context;
    return <div>{user.name}</div>
  }
}
```

Note that `static contextType = UserContext` assumes that you are using the experimental public class field{% 
sidenote 'public-class-field-explanation' 'Both public and private field declarations are an 
experimental feature (stage 3) proposed at TC39, the JavaScript standards committee.<br /><br />Support in browsers is limited, but the feature can be used through a build step with systems like Babel.'%}. If you are not, then use the code sample below instead.

```tsx
import React from 'react';
import UserContext from './UserContext';

class Home extends React.Component {
  componentDidMount() {
    const { user } = this.context;
    console.log(user); // { name: 'Oshomo Oforomeh' }
  }

  render() {
    const { user } = this.context;
    return <div>{user.name}</div>
  }
}

Home.contextType = UserContext;
```

The static `contextType` has one drawback, it doesn't allow a class component to consume multiple `Provider`. To 
consume multiple provider in a class component, we wrap our component with the `Consumer` component, which requires 
a function as a child and the function receives the current context `Provider` value like below. This method can 
also be used when consuming a single `Provider`.

Consuming single provider with `Consumer`.

```tsx
import React from 'react';
import { UserConsumer } from './UserContext';

class Home extends React.Component {
  render() {
    return (
      <UserConsumer>
        {({ user }) => {
          return <div>{user.name}</div>
        }}
      </UserConsumer>
    );
  }
}
```

Consuming multiple provider with `Consumer`.

```tsx
import React from 'react';
import { UserConsumer } from './UserContext';
import { ThemeConsumer } from './ThemeContext';

class Home extends React.Component {
  render() {
      return (
        <ThemeConsumer>
          {(theme) => (
            <UserConsumer>
              {({ user }) => {
                return (
                  <div>
                    <span>{theme.color}</span>
                    <span>{user.name}</span>
                  </div>
                )
              }}
            </UserConsumer>
          )}
        </ThemeConsumer>
      );
  }
}
```

### Functional Components & Hooks

Functional components are much simpler, whether you are consuming one or multiple provider. To do so we use the 
`useContext` hook which is equivalent to the static `contextType` we used in the class component. The only 
difference is we can use multiple hooks in a functional component, thus giving us the ability to consume multiple 
provider with ease.

```tsx
import React from 'react';
import UserContext from './UserContext';

const Home = () => {
  const { user } = React.useContext(UserContext);
  // You can add as much context as you want
  // const theme = React.useContext(ThemeContext);

  return <div>{user.name}</div>;
}
```

## Updating Context

Sometimes you find you might want to update the context value from a deeply nested component down the tree, like 
changing a theme from light to dark and vice versa. In this case, you can pass an update function down through the 
context value to allow consumers use this function to update the context value. Lets make an update to our initial 
context provider: 

 ```tsx
import React from 'react';

const UserContext = React.createContext({
  user: null,
  updateUser: () => {}
});

export const UserProvider = ({ children }) => {
  const [user, updateUser] = React.useState(null);

  return (
    <UserContext.Provider
      value={{
        user,
        updateUser
      }}
    >
      {children}
    </UserContext.Provider>
  )
};

export const UserConsumer = UserContext.Consumer;

export default UserContext;
```

Now we can get the user value from the context as we did before as well as update the user value in the context like 
below:

```tsx
import React from 'react';
import UserContext from './UserContext';

const Home = () => {
  const { user, updateUser } = React.useContext(UserContext);

  return (
    <div>
      <button onClick={() => updateUser({ name: 'Oshomo Updated' })}>
        Update User
      </button>
      <p>{`Current User: ${user.name}`}</p>
    </div>
  );
}
```

## Conclusion

Use `React.createContext()` to create context and get the `Provider` and `Consumer` from the created context.

I advise you wrap `Provider` in a parent component so you can easily manage `Provider` value.

You can consume a context in a class by using `static contextType = Context` inside the class or `Class.contextType = Context`.

To consume multiple context in a class, wrap you component in `<Context.Consumer>{component}</Context.Consumer>`.

You can consume one or more context in a functional component by using `React.useContext(Context)`.


