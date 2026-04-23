<?php
// ===================================================
// FILE: roti515_api/login.php
// API endpoint untuk login
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
// Ambil data JSON yang dikirim Flutter
$input = json_decode(file_get_contents('php://input'), true);
$email    = $input['email'] ?? '';      // ambil email, default kosong jika tidak ada
$password = $input['password'] ?? '';   // ambil password

// Validasi — pastikan email & password tidak kosong
if (empty($email) || empty($password)) {
    echo json_encode(['success' => false, 'message' => 'Email dan password wajib diisi']);
    exit;
}

// Koneksi ke database MySQL
$conn = new mysqli('localhost', 'root', '', 'roti_515');

// Cek apakah koneksi berhasil
if ($conn->connect_error) {
    echo json_encode(['success' => false, 'message' => 'Koneksi database gagal']);
    exit;
}

// Cari user berdasarkan email
// "?" dipakai untuk keamanan (mencegah SQL injection)
$stmt = $conn->prepare('SELECT id, nama, email, password, role FROM users WHERE email = ?');
$stmt->bind_param('s', $email);   // 's' = tipe string
$stmt->execute();
$result = $stmt->get_result();

// Cek apakah email ditemukan
if ($result->num_rows === 0) {
    echo json_encode(['success' => false, 'message' => 'Email tidak ditemukan']);
    exit;
}

$user = $result->fetch_assoc();   // ambil data user sebagai array

// Verifikasi password — password_verify membandingkan dengan hash
if (!password_verify($password, $user['password'])) {
    echo json_encode(['success' => false, 'message' => 'Password salah']);
    exit;
}

// Login berhasil! Buat token sederhana
// Nanti bisa diganti JWT untuk keamanan lebih baik
$token = bin2hex(random_bytes(32));   // token acak 64 karakter

// Kirim response sukses ke Flutter
echo json_encode([
    'success' => true,
    'token'   => $token,
    'user'    => [
        'id'    => $user['id'],
        'nama'  => $user['nama'],
        'email' => $user['email'],
        'role'  => $user['role'],
    ]
]);

$conn->close();   // tutup koneksi database
?>