<?php

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "testdb";
$table = "Employees";
// We will get action from the app to do opertaions on database
if (isset($_POST['action'])) {
    $action = $_POST['action'];
    // Create connection
    $conn = new mysqli($servername, $username, $password, $dbname);
    // Check connection
}

//Check connection
else {
    die("Connection failed:");
    return;
}
//if connection is successful
if ("CREATE_TABLE" == $action) {
    $sql = "CREATE TABLE IF NOT EXISTS $table(
            id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
            name VARCHAR(30) NOT NULL,
            email VARCHAR(50) NOT NULL,
            phone VARCHAR(30) NOT NULL,
            address VARCHAR(50) NOT NULL
        )";
    if ($conn->query($sql) === TRUE) {
        echo "Table created successfully";
    } else {
        echo "Error creating table:" . $conn->error;
    }
    $conn->close();
    return;
}
if ("GET_ALL" == $action) {
    $sql = "SELECT id,name,email,phone,address  FROM $table ORDER BY id DESC";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $db_data[] = $row;
        }
        echo json_encode($db_data);
    } else {
        echo "0 results";
    }
    $conn->close();
    return;
}
if ("ADD_EMP" == $action) {
    $name = $_POST["name"];
    $email = $_POST["email"];
    $phone = $_POST["phone"];
    $address = $_POST["address"];
    $sql = "INSERT INTO $table(name,email,phone,address) VALUES('$name','$email','$phone','$address')";
    $result = $conn->query($sql);
    echo "success";
    $conn->close();
    return;
}
if ("UPDATE_EMP" == $action) {
    $id = $_POST["id"];
    $name = $_POST["name"];
    $email = $_POST["email"];
    $sql = "UPDATE $table SET name='$name',email='$email' WHERE id='$id'";
    if ($conn->query($sql) === TRUE) {
        echo "success";
    } else {
        echo "Error updating record:" . $conn->error;
    }
    $conn->close();
    return;
}
if ("DELETE_EMP" == $action) {
    $id = $_POST["id"];
    $sql = "DELETE FROM $table WHERE id='$id'";
    if ($conn->query($sql) === TRUE) {
        echo "success";
    } else {
        echo "Error deleting record:" . $conn->error;
    }
    $conn->close();
    return;
}
