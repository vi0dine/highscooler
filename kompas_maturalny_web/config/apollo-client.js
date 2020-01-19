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

export default withApollo(
    ({ initialState }) =>
        new ApolloClient({
            link: link,
            cache: new InMemoryCache()
                .restore(initialState || {})
        })
);