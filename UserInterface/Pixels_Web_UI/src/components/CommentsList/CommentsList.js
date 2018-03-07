import React from 'react';
import { connect } from 'react-redux';
import DeleteCommentsList from '../CommentsList/DeleteCommentsList';

const CommentsList = (props) => (
     <div>
         <div>
            {props.comments.map((comment) => {
             return <DeleteCommentsList key={comment.id}  {...comment} />
            })}
         </div>
     </div>
);

const mapStateToProps = (state) => {
    return {
        comments:state.comments
    };
};

 export default connect(mapStateToProps)(CommentsList);

 