import React from 'react';
import BasicLayout from "../components/layouts/BasicLayout.layout";
import {useQuery} from "@apollo/react-hooks";
import {ACADEMIES_QUERY} from "../graphql/queries/academies";
import {Row} from "antd";
import AcademyCard from "../components/AcademyCard/AcademyCard.component";
import InfiniteScroll from "react-infinite-scroller";

const ACADEMIES_PER_PAGE = 20;

const Academies = () => {
    const {data, loading, error, fetchMore} = useQuery(ACADEMIES_QUERY, {
        variables: {
            first: ACADEMIES_PER_PAGE,
            after: null
        },
        onError: (error) => console.log(error.message)
    });

    return !loading && (
        <BasicLayout>
            <div className={'Academies'}>
                <Row style={{height: '88vh', overflowY: 'auto'}}>
                    <InfiniteScroll
                        initialLoad={false}
                        useWindow={false}
                        className={'Academies_Array'}
                        pageStart={0}
                        loadMore={() => fetchMore({
                            variables: {
                                first: data.academies.totalCount - data.academies.edges.length < ACADEMIES_PER_PAGE
                                    ? ACADEMIES_PER_PAGE : data.academies.totalCount - data.academies.edges.length,
                                after: data.academies.pageInfo.endCursor
                            },
                            updateQuery: (prev, { fetchMoreResult }) => {
                                if (!fetchMoreResult) return prev;
                                return {
                                    ...prev,
                                    pageInfo: fetchMoreResult.academies.pageInfo,
                                    academies: {
                                        ...prev.academies,
                                        edges: [...prev.academies.edges, ...fetchMoreResult.academies.edges]
                                    }
                                }
                            }
                        })}
                        hasMore={data.academies.edges.length < data.academies.totalCount}
                        loader={<div className="loader" key={0}>Loading ...</div>}
                    >
                        {
                            !error && data.academies.edges.map(({node}) => (
                                <AcademyCard
                                    key={node.id}
                                    name={node.name}
                                    city={node.city}
                                    fieldsCounter={node.fieldOfStudies.length}/>
                            ))
                        }
                    </InfiniteScroll>
                </Row>
            </div>
        </BasicLayout>
    );
};

export default Academies;