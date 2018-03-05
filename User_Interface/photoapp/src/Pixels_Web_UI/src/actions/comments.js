import uuid from 'uuid';

 export const AddComment = (
     { 
         comment = '',
         commented_by = '',
         commented_on = ''
     } = {}
 ) => ({
         type: 'ADD_COMMENT',
         Comments: {
             id: uuid(),
             comment,
             commented_by,
             commented_on
         }
     });

// export const Edit = ({id, updates} = {}) => {
//     console.log('ajaja');
//     return {
//         type:'EDIT_COMMENT',
//         id,
//         updates
//     };
// };

export const EditComment = (id, updates)  => ({
        type:'EDIT_COMMENT',
        id,
        updates
});


export const DeleteComment = ({id} = {}) => {
    return {
        type: 'DELETE_COMMENT',
        id
    };
};

