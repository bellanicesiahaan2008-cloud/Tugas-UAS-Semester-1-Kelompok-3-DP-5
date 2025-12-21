program PendataanNilaiMahasiswa;
uses crt;
const
  Maks = 150;                              // Batas maksimum mahasiswa
  
type
  TMahasiswa = record                    // Record data mahasiswa
    nama : string;                       // Nama mahasiswa
    nim  : string;                       // NIM mahasiswa
    nilai: integer;                      // Nilai mahasiswa
  end;

var
  pilihan: integer;                    // Menu pilihan
  rata    : real;                      // Menyimpan rata-rata nilai
  data : array[1..Maks] of TMahasiswa;   // Array record mahasiswa
  n    : integer;                        // Jumlah mahasiswa


procedure inputJumlah();                 // Prosedur input jumlah mahasiswa
begin
  repeat
    write('Masukkan jumlah mahasiswa: '); 
    readln(n);
    if (n > maks) or (n < 0) then
    begin
      writeln('Jumlah mahasiswa tidak valid atau melebihi batas! Tekan enter untuk masukkan ulang!');
      readln;
      clrscr;
    end;
  until (0 < n) and (n < maks);     // Batasi jika melebihi Maks
end;

procedure inputData();                   // Prosedur input data mahasiswa
var 
  i: integer;
begin
  clrscr;                               // Bersihkan layar
  writeln('=== INPUT DATA MAHASISWA ===');
  for i := 1 to n do                    // Loop input sesuai jumlah mahasiswa
  begin
    writeln('Mahasiswa ke-', i);
    write('  Nama  : '); readln(data[i].nama);  // Input nama
    write('  NIM   : '); readln(data[i].nim);   // Input NIM
    write('  Nilai : '); readln(data[i].nilai); // Input nilai
  end;
end;

procedure tampilData();                  // Prosedur menampilkan data
var 
  i: integer;
begin
  clrscr;
  writeln('=== DATA NILAI MAHASISWA ===');
  for i := 1 to n do                    // Loop menampilkan data
  begin
    writeln(i, '. ', data[i].nama, ' (', data[i].nim,
            ') - Nilai: ', data[i].nilai);
  end;
end;

function hitungRata(): real;             // Fungsi menghitung rata-rata nilai
var 
  i, total: integer;
begin
  total := 0;                           // Inisialisasi total
  for i := 1 to n do                    // Loop penjumlahan nilai
    total := total + data[i].nilai;

  hitungRata := total / n;              // Nilai balik fungsi
end;

procedure cariMahasiswa();               // Prosedur mencari mahasiswa
var
  cari: string;                         // NIM yang dicari
  i: integer;
  ketemu: boolean;                      // Penanda data ditemukan
begin
  clrscr;
  ketemu := false;                      // Awal: data belum ditemukan

  write('Masukkan NIM yang dicari: ');
  readln(cari);                         // Input NIM pencarian

  for i := 1 to n do                    // Loop pencarian data
  begin
    if data[i].nim = cari then          // Jika NIM cocok
    begin
      ketemu := true;                  // Data ditemukan
      writeln('Data ditemukan!');
      writeln('Nama  : ', data[i].nama);
      writeln('Nilai : ', data[i].nilai);

      if data[i].nilai >= 75 then       // Cek kelulusan
        writeln('Status: LULUS')
      else
        writeln('Status: TIDAK LULUS');
    end;
  end;

  if not ketemu then                    // Jika data tidak ditemukan
    writeln('Data tidak ditemukan...');
end;

procedure urutkanNilai();               // Prosedur mengurutkan nilai
var
  i, j: integer;
  temp: TMahasiswa;                    // Variabel sementara penukar data
begin  // mengurutkan dari nilai terbesar ke terkecil
  for i := 1 to n-1 do                 // Loop pertama
    for j := i+1 to n do               // Loop pembanding
      if data[i].nilai < data[j].nilai then // Kondisi tukar
      begin
        temp := data[i];               // Tukar data
        data[i] := data[j];
        data[j] := temp;
      end;

  writeln('Data berhasil diurutkan dari nilai tertinggi ke terendah.');
end;

procedure tampilTigaTertinggi;        // Prosedur tampil 3 nilai tertinggi
var
  i, batas: integer;
begin
  clrscr;
  writeln('=== 3 NILAI TERTINGGI ===');

  if n < 3 then                         // Jika mahasiswa < 3
    batas := n
  else
    batas := 3;                         // Maksimal 3 data

  for i := 1 to batas do                // Loop menampilkan data
  begin
    writeln(i, '. ', data[i].nama, ' (', data[i].nim,
            ') - Nilai: ', data[i].nilai);
  end;
end;



begin
  clrscr;
  inputJumlah();                       // Panggil input jumlah mahasiswa

  repeat                               // Perulangan menu
    clrscr;
    writeln('===== MENU NILAI MAHASISWA =====');
    writeln('1. Input Data Mahasiswa');
    writeln('2. Tampilkan Semua Data');
    writeln('3. Cari Mahasiswa berdasarkan NIM');
    writeln('4. Hitung Rata-rata Nilai');
    writeln('5. Urutkan Nilai (Ranking)');
    writeln('6. Tampilkan 3 Nilai Tertinggi');
    writeln('7. Keluar');
    writeln('=============================');
    write('Pilihan: '); 
    readln(pilihan);                   // Input pilihan menu

    case pilihan of                    // Percabangan menu
      1: inputData();                  // Menu input data
      2: tampilData();                 // Menu tampil data
      3: cariMahasiswa();              // Menu cari mahasiswa
      4:
      begin
        rata := hitungRata();          // Panggil fungsi rata-rata
        writeln('Rata-rata nilai: ', rata:0:2);
      end;
      5: urutkanNilai();               // Menu urut nilai
      6: tampilTigaTertinggi();        // Menu top 3 nilai
      7: writeln('Keluar...');          // Keluar program
    else
      writeln('Pilihan tidak valid!');
    end;

    writeln;
    writeln('Tekan ENTER untuk melanjutkan...');
    readln;

  until pilihan = 7;                   // Berhenti jika pilih 7

end.