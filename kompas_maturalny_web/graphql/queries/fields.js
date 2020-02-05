import gql from 'graphql-tag';

export const FIELDS_QUERY = gql`
    query fields($first: Int, $after: String) {
      fields(first: $first, after: $after) {
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
            academies {
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
        academies {
          id
          name
          city
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