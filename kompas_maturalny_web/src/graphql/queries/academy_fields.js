import { gql } from "@apollo/client";

export const CHECK_RESULT = gql`
    query recruitment_points($id: ID!) {
        recruitmentPoints(id: $id)
    }
`;