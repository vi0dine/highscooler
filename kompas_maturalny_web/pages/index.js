import React from 'react';
import BasicLayout from "../components/layouts/BasicLayout.layout";
import {useQuery} from "@apollo/react-hooks";
import {USERS_QUERY} from "../graphql/queries/users";

const Home = () => {
    const {data, loading, error} = useQuery(USERS_QUERY, {
        onError: (error) => console.log(error.message)
    });

    return !loading && (
        <BasicLayout>
            <div>
                {
                    !error && data.users.map(user => (
                        <p>{user.email}</p>
                    ))
                }
            </div>
        </BasicLayout>
    );
};

export default Home;