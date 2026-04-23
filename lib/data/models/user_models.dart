class UserModel {
  final String name;
  final String gender;
  final double height; // Kita pakai cm sesuai request kamu
  final double weight; // Kita pakai kg sesuai request kamu
  final String goal;

  UserModel({
    required this.name,
    required this.gender,
    required this.height,
    required this.weight,
    required this.goal,

  }) {
    // === Design by Contract (DbC): Pre-conditions ===
    
    // 1. Validasi Nama
    assert(name.isNotEmpty, "Nama tidak boleh kosong");
    assert(name.length >= 3, "Nama minimal harus 3 karakter");

    // 2. Validasi Gender (Hanya boleh Male, Female, atau Other)
    assert(['Male', 'Female', 'Other'].contains(gender), "Gender tidak valid");

    // 3. Validasi Tinggi Badan (Logika: Manusia dewasa rata-rata 50-250cm)
    assert(height > 50 && height < 250, "Tinggi badan harus di antara 50-250 cm");

    // 4. Validasi Berat Badan (Logika: Berat badan manusia rata-rata 10-300kg)
    assert(weight > 10 && weight < 300, "Berat badan harus di antara 10-300 kg");

    assert(['Lose Weight', 'Maintain Weight', 'Gain Muscle'].contains(goal), "Goal tidak valid");
  }
}