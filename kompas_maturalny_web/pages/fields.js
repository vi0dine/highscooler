import React from 'react';
import { Row, Col } from "antd";
import BasicLayout from "../components/layouts/BasicLayout.layout";
import {useQuery} from "@apollo/react-hooks";
import {FIELDS_QUERY} from "../graphql/queries/fields";
import FieldCard from "../components/FieldCard/FieldCard.component";

const Fields = () => {
    const {data, loading, error} = useQuery(FIELDS_QUERY, {
        onError: (error) => console.log(error.message)
    });

    return !loading && (
        <BasicLayout>
            <div className={'Fields'}>
                <Row className={'Fields_Array'}>
                    {
                        !error && data.fields.map(field => (
                            <FieldCard name={field.name} description={field.description} academiesCounter={12}/>
                        ))
                    }
                </Row>
            </div>
        </BasicLayout>
    );
};

export default Fields;