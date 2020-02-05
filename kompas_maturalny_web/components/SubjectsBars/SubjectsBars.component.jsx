import React from "react";
import './SubjectsBars.styles.scss';
import { Row, Col } from 'antd';

const SubjectsBars = ({subjects, total}) => {
    const getPercentageHeight = (subject) => {
        const acc = subjects.map(sub => sub.count).reduce((a,b) => a+b);
        return `${(subject.count / acc)*100}%`
    };

    const getPercentageOfTotal = (subject) => {
        return `${Math.round(((subject.count / total) + Number.EPSILON) * 100) / 100}%`
    };

    return (
        <Row className={'SubjectsBars'} type={'flex'}>
            <Col className={'SubjectsBars_bar-1'} style={{height: getPercentageHeight(subjects[0])}}>
                <span>{getPercentageOfTotal(subjects[0])}</span>
                <p>{subjects[0].subject}</p>
            </Col>
            <Col className={'SubjectsBars_bar-2'} style={{height: getPercentageHeight(subjects[1])}}>
                <span>{getPercentageOfTotal(subjects[1])}</span>
                <p>{subjects[1].subject}</p>
            </Col>
            <Col className={'SubjectsBars_bar-3'} style={{height: getPercentageHeight(subjects[2])}}>
                <span>{getPercentageOfTotal(subjects[2])}</span>
                <p>{subjects[2].subject}</p>
            </Col>
            <Col className={'SubjectsBars_bar-4'} style={{height: getPercentageHeight(subjects[3])}}>
                <span>{getPercentageOfTotal(subjects[3])}</span>
                <p>{subjects[3].subject}</p>
            </Col>
        </Row>
    );
};

export default SubjectsBars;