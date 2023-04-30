<?php

// Connect to the database
$db = new mysqli('mysql', 'MYSQL_USER', 'MYSQL_PASSWORD', 'MYSQL_DATABASE');

echo '<h1>Bienvenue sur le b2b<h1/>';

// Create a text input and a submit button
echo '<form action="index.php" method="post">';
echo '<input type="text" name="text_input" />';
echo '<input type="submit" value="Add" />';
echo '</form>';

// If the user clicks on the submit button, add the data from the text input to the database
if (isset($_POST['text_input']) && !empty($_POST['text_input'])) {
    $query = 'INSERT INTO mytable (input) VALUES ("' . $_POST['text_input'] . '")';
    $result = $db->query($query);
}

// Get all the data from the database and display it below the text input
$query = 'SELECT * FROM mytable';
$result = $db->query($query);

while ($row = $result->fetch_assoc()) {
    echo '<p>' . $row['input'] . '</p>';
}

// Add a button that deletes everything in the database
echo '<form action="index.php" method="post">';
echo '<input type="submit" name="delete_button" value="Delete Everything" />';
echo '</form>';

// If the user clicks on the delete button, delete all of the data in the database
if (isset($_POST['delete_button'])) {
    $query = 'TRUNCATE TABLE mytable;';
    $result = $db->query($query);
}
?>
