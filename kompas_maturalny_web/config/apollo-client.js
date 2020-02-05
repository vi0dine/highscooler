import { ApolloClient } from 'apollo-client';
import { InMemoryCache } from 'apollo-cache-inmemory';
import withApollo from 'next-with-apollo';
import { createHttpLink } from 'apollo-link-http';
import fetch from 'isomorphic-unfetch';
import {Cookies} from 'react-cookie';

const cookies = new Cookies();

const GRAPHQL_URL = 'http://localhost:4000/graphql';

const link = createHttpLink({
    fetch,
    headers: { Authorization: `Bearer ${cookies.get('token')}` },
    uri: GRAPHQL_URL
});

const cache = new InMemoryCache();
const client = new ApolloClient({
    link: link,
    cache,
    resolvers: { /* ... */ },
});

cache.writeData({
    data: {
        userFields: []
    }
});

export default withApollo(
    () => client
);