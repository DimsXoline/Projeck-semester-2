<?php
// ===================================================
// FILE: roti515_api/register.php
// API endpoint untuk daftar akun baru
// ===================================================

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');
header('Content-Type: application/json');

// Handle preflight request dari browser
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

// Hanya terima method POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['success' => false, 'message' => 'Method tidak diizinkan']);
    exit;
}

// Ambil data JSON dari Flutter
$input = json_decode(file_get_contents('php://input'), true);
$nama     = $input['nama'] ?? '';
$email    = $input['email'] ?? '';
$phone    = $input['phone'] ?? '';
$password = $input['password'] ?? '';

// Validasi — pastikan semua field terisi
if (empty($nama) || empty($email) || empty($password)) {
    echo json_encode(['success' => false, 'message' => 'Semua field wajib diisi']);
    exit;
}

// Validasi format email
if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    echo json_encode(['success' => false, 'message' => 'Format email tidak valid']);
    exit;
}

// Validasi panjang password minimal 8 karakter
if (strlen($password) < 8) {
    echo json_encode(['success' => false, 'message' => 'Password minimal 8 karakter']);
    exit;
}

// Koneksi ke database
$conn = new mysqli('localhost', 'root', '', 'roti_515');

if ($conn->connect_error) {
    echo json_encode(['success' => false, 'message' => 'Koneksi database gagal']);
    exit;
}

// Cek apakah email sudah terdaftar
$checkStmt = $conn->prepare('SELECT id FROM users WHERE email = ?');
$checkStmt->bind_param('s', $email);
$checkStmt->execute();
$checkResult = $checkStmt->get_result();

if ($checkResult->num_rows > 0) {
    echo json_encode(['success' => false, 'message' => 'Email sudah terdaftar']);
    exit;
}

// Enkripsi password sebelum disimpan ke database
// password_hash = tidak bisa dibaca manusia, lebih aman
$hashedPassword = password_hash($password, PASSWORD_BCRYPT);

// Simpan user baru ke database
$stmt = $conn->prepare(
    'INSERT INTO users (nama, email, phone, password, role) VALUES (?, ?, ?, ?, "pelanggan")'
);
$stmt->bind_param('ssss', $nama, $email, $phone, $hashedPassword);
if ($stmt->execute()) {
    // Berhasil disimpan!
    echo json_encode([
        'success' => true,
        'message' => 'Akun berhasil dibuat',
        'user' => [
            'nama'  => $nama,
            'email' => $email,
            'role'  => 'pelanggan',
        ]
    ]);
} else {
    echo json_encode(['success' => false, 'message' => 'Gagal membuat akun']);
}

$conn->close();
?>