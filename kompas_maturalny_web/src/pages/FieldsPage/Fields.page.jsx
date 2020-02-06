import React from 'react';
import './Fields.styles.scss'
import { Row } from "antd";
import BasicLayout from "../../layouts/BasicLayout/BasicLayout.layout";
import {useQuery} from "@apollo/client";
import { useHistory } from 'react-router-dom';
import {FIELDS_QUERY} from "../../graphql/queries/fields";
import FieldCard from "../../components/FieldCard/FieldCard.component";
import InfiniteScroll from 'react-infinite-scroller';

const FIELDS_PER_PAGE = 20;

const FieldsPage = () => {
    const history = useHistory();
    const {data, loading, error, fetchMore} = useQuery(FIELDS_QUERY, {
        variables: {
            first: FIELDS_PER_PAGE,
            after: null
            },
        onError: (error) => console.log(error.message)
    });

    return !loading && (
        <BasicLayout>
            <div className={'FieldsPage'}>
                <Row style={{height: '88vh', overflowY: 'auto'}}>
                    <InfiniteScroll
                        initialLoad={false}
                        useWindow={false}
                        className={'Fields_Array'}
                        pageStart={0}
                        loadMore={() => fetchMore({
                            variables: {
                                first: data.fields.totalCount - data.fields.edges.length < FIELDS_PER_PAGE
                                    ? FIELDS_PER_PAGE : data.fields.totalCount - data.fields.edges.length,
                                after: data.fields.pageInfo.endCursor
                            },
                            updateQuery: (prev, { fetchMoreResult }) => {
                                if (!fetchMoreResult) return prev;
                                return {
                                    ...prev,
                                    pageInfo: fetchMoreResult.fields.pageInfo,
                                    fields: {
                                        ...prev.fields,
                                        edges: [...prev.fields.edges, ...fetchMoreResult.fields.edges]
                                    }
                                }
                            }
                        })}
                        hasMore={data.fields.edges.length < data.fields.totalCount}
                        loader={<div className="loader" key={0}>Loading ...</div>}
                    >
                        {
                            !error && data.fields.edges.map(({node}) => (
                                <FieldCard
                                    key={node.id}
                                    name={node.name}
                                    description={node.description}
                                    academiesCounter={node.academies.length}
                                    onClick={() => history.push(`/fields/${node.id}`)}
                                />
                            ))
                        }
                    </InfiniteScroll>
                </Row>
            </div>
        </BasicLayout>
    );
};

export default FieldsPage;