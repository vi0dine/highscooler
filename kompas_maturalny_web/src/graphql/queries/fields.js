import gql from 'graphql-tag';

export const FIELDS_QUERY = gql`
    query fields($first: Int, $after: String, $query: String) {
        fields(first: $first, after: $after, query: $query) {
            pageInfo {
                hasNextPage
                endCursor
            }
            totalCount
            edges {
                node {
                    id
                    name
                    description
                    academyFields {
                        id
                    }
                }
            }
        }
    }
`;

export const FIELD_QUERY = gql`
    query field($id: ID!) {
        field(id: $id) {
            id
            name
            description
            mostFrequentSubjects
            academyFields {
                id
                academy {
                    name
                    city
                }
            }
            reviews {
                title
                body
                rate
                reviewable {
                    academy {
                        name
                        city
                    }
                }
            }
        }
    }
`;