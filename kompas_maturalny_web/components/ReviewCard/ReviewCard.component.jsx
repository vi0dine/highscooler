import React from "react";
import './ReviewCard.styles.scss';
import { Row, Col, Rate, Icon } from "antd";

const ReviewCard = ({review}) => {
    return (
        <Row className={'ReviewCard'}>
            <Row className={'ReviewCard_Header_Container'}>
                <Col className={'ReviewCard_Header_Title_Container'} span={18}>
                    <Row>
                        <Col span={24}>
                            <span className={'ReviewCard_Header_Title_Text'}>{review.title}</span>
                        </Col>
                        <Col span={24}>
                            {
                                review.reviewable.academy ? (
                                    <span className={'ReviewCard_Header_Reviewable_Text'}>{review.reviewable.academy.name}</span>
                                ) : (
                                    <span className={'ReviewCard_Header_Reviewable_Text'}>{review.reviewable.fieldOfStudy.name}</span>
                                )
                            }
                        </Col>
                    </Row>
                </Col>
                <Col span={6}>
                    <Rate
                        className={'ReviewCard_Header_Rating'}
                        character={<Icon type={'heart'} theme={'filled'} />}
                        disabled
                        defaultValue={review.rate}/>
                </Col>
            </Row>
            <Row>
                <Col className={'ReviewCard_Content_Body_Container'} span={24}>
                    <span className={'ReviewCard_Content_Body_Text'}>{review.body}</span>
                </Col>
            </Row>
        </Row>
    );
};

export default ReviewCard;