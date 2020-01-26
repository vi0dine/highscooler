import React from 'react';
import BasicLayout from "../components/layouts/BasicLayout.layout";
import {useQuery} from "@apollo/react-hooks";
import {ACADEMIES_QUERY} from "../graphql/queries/academies";

const Academies = () => {
    const {data, loading, error} = useQuery(ACADEMIES_QUERY, {
        onError: (error) => console.log(error.message)
    });

    return !loading && (
        <BasicLayout>
            <div>
                {
                    !error && data.academies.map(academy => (
                        <p>{academy.name}</p>
                    ))
                }
            </div>
        </BasicLayout>
    );
};

export default Academies;