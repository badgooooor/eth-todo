pragma solidity >= 0.4.16 < 0.8.0;

contract TodoList {
    struct Task {
        uint id;
        uint date;
        string content;
        bool done;
    }
    
    uint private lastTaskId;
    uint[] private taskIds;
    mapping(uint => Task) private tasks;
    
    event TaskCreated(uint id, uint date, string content);
    event TaskStatusToggled(uint id, bool done);
    
    function createTask(string memory _content) public {
        lastTaskId++;
        tasks[lastTaskId] = Task(lastTaskId, now, _content, false);
        taskIds.push(lastTaskId);
        emit TaskCreated(lastTaskId, now, _content);
    }
    
    modifier taskExists(uint id) {
        require(tasks[id].id != 0);
        _;
    }
    
    function toggleTaskStatus(uint _id) taskExists(_id) public {
        tasks[_id].done != tasks[_id].done;
        emit TaskStatusToggled(_id, tasks[_id].done);
    }
    
    function getTaskIds() public view returns(uint[] memory) {
        return taskIds;
    }
    
    function getTask(uint _id) taskExists(_id) public view returns(uint , uint, string memory, bool) {
        return (_id, tasks[_id].date, tasks[_id].content, tasks[_id].done);
    }
}