import React, {useEffect, useState} from 'react';
import {ApolloClient, ApolloProvider, HttpLink, InMemoryCache} from '@apollo/client'
import {useCookies} from "react-cookie";
import './App.scss';
import {GRAPHQL_URL} from "./config/apollo-client";
import {persistCache} from 'apollo-cache-persist';
import Routes from "./router";

const App = () => {
    const [client, setClient] = useState(undefined);
    const [cookies, setCookies] = useCookies(['token']);
    useEffect(() => {
        const cache = new InMemoryCache();

        const client = new ApolloClient({
            link: new HttpLink({
                uri: GRAPHQL_URL,
                headers: {Authorization: `Bearer ${cookies.token}`}
            }),
            cache: cache
        });

        const initData = {
            UserState: {
                userFields: []
            }
        };

        cache.writeData({data: initData});

        persistCache({
            cache,
            storage: window.localStorage
        }).then(() => {
            client.onResetStore(async () => cache.writeData({data: initData}));
            setClient(client);
        });
        return () => {
        };
    }, [cookies]);

    if (client === undefined) return <div>Loading...</div>;

    return (
        <ApolloProvider client={client}>
            <Routes/>
        </ApolloProvider>
    );
};

export default App;
