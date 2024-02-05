<?php
// Database configuration
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "react_app_test";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Allow requests from your React app's origin
header("Access-Control-Allow-Origin: *");  // Update this with your React app's origin
// Allow the following methods for preflight requests
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
// Allow the following headers for preflight requests
header("Access-Control-Allow-Headers: Content-Type, Authorization");
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);  // No content for OPTIONS requests
    header("Content-Length: 0");
    exit();
}

// API to save data
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['save_user'])) {
    // Get data from the request
    $name = $_POST['name'];
    $sector_id = $_POST['sector_id'];
    $agree_to_terms = $_POST['agreeToTerms'] == true ? 1 : 0;

    // Save data to the database
    $sql = "INSERT INTO users (name, sector_id, agree_to_terms) VALUES ('$name', '$sector_id', '$agree_to_terms')";

    if ($conn->query($sql) === TRUE) {
        // Create a unique token and store it in the database
        $user_id = $conn->insert_id;
        $token = $user_id . '_'. bin2hex(random_bytes(32));
        $conn->query("UPDATE users SET token = '$token' WHERE id = $user_id");

        echo json_encode(['status' => 'success', 'token' => $token]);
    } else {
        echo json_encode(['status' => 'error', 'message' => $conn->error]);
    }
}

// API to return data
if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_REQUEST['get_user_data'])) {

    if (isValidToken()) {
        $user_id = getUserIdFromToken();

        // Retrieve data for the specific user from the database with a join operation
        $result = $conn->query("SELECT users.name, users.sector_id, sectors.title AS sector_title FROM users 
                                LEFT JOIN sectors ON users.sector_id = sectors.id 
                                WHERE users.id = '$user_id'");

        if ($result->num_rows > 0) {
            $data = [];

            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }

            echo json_encode(['status' => 'success', 'data' => $data]);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'No data found']);
        }
    } else {
        echo json_encode(['status' => 'error', 'message' => 'User not authenticated']);
    }
}

// API to update data
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_REQUEST['update_info'])) {
    // Ensure the user is authenticated
    if (isValidToken()) {
        $user_id = getUserIdFromToken();

        // Get data from the request
        $name = isset($_POST['name']) ? $_POST['name'] : '';
        $sector_id = isset($_POST['sector_id']) ? $_POST['sector_id'] : '';

        if (empty($name) || empty($sector_id)) {
            echo json_encode(['status' => 'error', 'message' => 'Name and sector are required for update']);
            exit;
        }

        // Update data in the database
        $updateSql = "UPDATE users SET name = '$name', sector_id = '$sector_id' WHERE id = '$user_id'";

        if ($conn->query($updateSql) === TRUE) {
            echo json_encode(['status' => 'success', 'message' => 'Data updated successfully']);
        } else {
            echo json_encode(['status' => 'error', 'message' => $conn->error]);
        }
    } else {
        echo json_encode(['status' => 'error', 'message' => 'User not authenticated']);
    }
}


// API to return All the sectors
if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_REQUEST['get_sectors'])) {
    $result = $conn->query("SELECT id, title FROM sectors");

    if ($result->num_rows > 0) {
        $data = [];

        while ($row = $result->fetch_assoc()) {
            $data[] = $row;
        }

        echo json_encode(['status' => 'success', 'data' => $data]);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'No data found']);
    }
}

// Helper function to validate the token (replace this with your actual validation logic)
function isValidToken() {
    $headers = getallheaders();
    $token = isset($headers['Authorization']) ? trim(str_replace('Bearer', '', $headers['Authorization'])) : null;
    global $conn;

    $tokenParts = explode('_', $token);

    if (count($tokenParts) === 2) {
        $user_id = $tokenParts[0];
        $result = $conn->query("SELECT id FROM users WHERE id = '$user_id' AND token = '$token'");

        if ($result->num_rows > 0) {
            return $user_id;
        }
    }
    return null;
}

// Helper function to get user ID from the token (replace this with your actual logic)
function getUserIdFromToken() {
    $headers = getallheaders();
    $token = isset($headers['Authorization']) ? trim(str_replace('Bearer', '', $headers['Authorization'])) : null;
    $tokenParts = explode('_', $token);
    if (count($tokenParts) === 2) {
        $user_id = $tokenParts[0];
        return $user_id;
    }else{
        return false;
    }
}



// Close the database connection
$conn->close();
?>
