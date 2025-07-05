<?php
header("Content-Type: application/json");

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $name    = htmlspecialchars(strip_tags($_POST['name']));
    $email   = htmlspecialchars(strip_tags($_POST['email']));
    $subject = htmlspecialchars(strip_tags($_POST['subject']));
    $message = htmlspecialchars(strip_tags($_POST['message']));

    $to = "doreakibaka@gmail.com"; 
    $headers = "From: $email\r\n";
    $headers .= "Reply-To: $email\r\n";
    $headers .= "Content-Type: text/plain; charset=UTF-8\r\n";

    $fullMessage = "Nom: $name\nEmail: $email\nSujet: $subject\n\n$message";

    if (mail($to, $subject, $fullMessage, $headers)) {
        echo json_encode(["message" => "Message envoyé avec succès."]);
    } else {
        http_response_code(500);
        echo json_encode(["message" => "Erreur lors de l'envoi du message."]);
    }
} else {
    http_response_code(405);
    echo json_encode(["message" => "Méthode non autorisée."]);
}
?>