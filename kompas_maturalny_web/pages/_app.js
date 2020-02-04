import React, {useEffect, useState} from 'react';
import Router from "next/router";
import { useCookies } from 'react-cookie';
import '../styles.scss';
import { ApolloProvider } from '@apollo/react-hooks';

import withApollo from '../config/apollo-client';

const MyApp = ({Component, pageProps, apollo}) => {
    const [authorized, setAuthorized] = useState(false);
    const [cookies] = useCookies(['token']);

    useEffect(() => {
        if ( !cookies.token ) {
            Router.push('/login').then(() => {
                setAuthorized(true)
            })
        } else {
            setAuthorized(true)
        }
    }, []);

    return authorized && (
        <ApolloProvider client={apollo}>
            <Component {...pageProps} />
        </ApolloProvider>
    );
};

// Wraps all components in the tree with the data provider
export default withApollo(MyApp);