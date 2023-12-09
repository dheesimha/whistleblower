// SPDX-License-Identifier:MIT 
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

contract Whistleblower {
    struct Post {
        uint256 post_id;
        string post_title;
        string post_description;
        string file_address;
        string uploader_id;
        string[] user_id;
        string[] comments;
        uint256 upvotes;
        uint256 downvotes;
        uint256 commentsSize;

    }

    Post[] public postsArray;

    function createPost(
        string memory post_title,
        string memory post_description,
        string memory file_address,
        string memory uploader_id
    ) public {
        Post memory post;
        post.post_title = post_title;
        post.post_description = post_description;
        post.file_address = file_address;
        post.uploader_id = uploader_id;
        post.post_id = postsArray.length + 1;
        postsArray.push(post);
    }

    function getPost(uint256 post_id) public view returns (
        uint256, 
        string memory, 
        string memory, 
        string memory, 
        string memory, 
        uint256, 
        uint256
    ) {
        require(post_id > 0 && post_id <= postsArray.length, "Invalid post_id");
        
        Post memory post = postsArray[post_id - 1];
        return (
            post.post_id,
            post.post_title,
            post.post_description,
            post.file_address,
            post.uploader_id,
            post.upvotes,
            post.downvotes
        );
    }


    function castVote(uint256 post_id, uint256 choice) public {
        require(post_id > 0 && post_id <= postsArray.length, "Invalid post_id");
        
        if (choice == 1) {
            postsArray[post_id - 1].upvotes++;
        } else if (choice == 2) {
            postsArray[post_id - 1].downvotes++;
        } else {
            revert("Invalid choice");
        }
    }

    function addComments(uint256 post_id, string memory comment, string memory user_id) public {
        require(post_id > 0 && post_id <= postsArray.length, "Invalid post_id");
        
        postsArray[post_id - 1].user_id.push(user_id);
        postsArray[post_id-1].comments.push(comment);
    }

   function getCommentsByPost(uint256 post_id) public view returns (string[] memory, string[] memory) {
    require(post_id > 0 && post_id <= postsArray.length, "Invalid post_id");

    Post storage post = postsArray[post_id - 1];
    return (post.user_id, post.comments);
}


}
