import React from 'react';
import BasicLayout from "../components/layouts/BasicLayout.layout";
import {useQuery} from "@apollo/react-hooks";
import {FIELDS_QUERY} from "../graphql/queries/fields";

const Fields = () => {
    const {data, loading, error} = useQuery(FIELDS_QUERY, {
        onError: (error) => console.log(error.message)
    });

    return !loading && (
        <BasicLayout>
            <div>
                {
                    !error && data.fields.map(field => (
                        <p>{field.name}</p>
                    ))
                }
            </div>
        </BasicLayout>
    );
};

export default Fields;