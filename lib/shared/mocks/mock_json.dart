import 'package:barberhub/shared/models/Appointment.dart';
import 'package:barberhub/shared/models/barber.dart';
import 'package:barberhub/shared/models/client.dart';
import 'package:barberhub/shared/models/service.dart';

// ========== SERVICES ==========
final List<Service> mockServices = [
  Service(id: 's1', name: 'Corte', price: 45.0, durationMinutes: 30),
  Service(id: 's2', name: 'Barba', price: 35.0, durationMinutes: 30),
  Service(id: 's3', name: 'Corte + Barba', price: 70.0, durationMinutes: 60),
  Service(id: 's4', name: 'Sobrancelha', price: 20.0, durationMinutes: 15),
  Service(id: 's5', name: 'Pezinho', price: 15.0, durationMinutes: 15),
];

// ========== BARBERS ==========
final List<Barber> mockBarbers = [
  Barber(
    id: 'b1',
    name: 'Carlos Mendes',
    email: 'carlos@barberhub.com',
    password: '123456',
    birthDate: DateTime(1990, 3, 14),
    offeredServiceIds: ['s1', 's2', 's3', 's5'],
    startMinutes: 540, // 09:00
    endMinutes: 1080, // 18:00
  ),
  Barber(
    id: 'b2',
    name: 'Rafael Souza',
    email: 'rafael@barberhub.com',
    password: '123456',
    birthDate: DateTime(1995, 7, 2),
    offeredServiceIds: ['s1', 's2', 's3', 's4'],
    startMinutes: 600, // 10:00
    endMinutes: 1140, // 19:00
  ),
  Barber(
    id: 'b3',
    name: 'Diego Almeida',
    email: 'diego@barberhub.com',
    password: '123456',
    birthDate: DateTime(1988, 11, 25),
    offeredServiceIds: ['s1', 's3', 's4', 's5'],
    startMinutes: 540, // 09:00
    endMinutes: 1020, // 17:00
  ),
];

// ========== CLIENTS ==========
final List<Client> mockClients = [
  Client(
    id: 'u1',
    name: 'João Pereira',
    email: 'joao@email.com',
    password: '123456',
    birthDate: DateTime(1998, 5, 10),
  ),
  Client(
    id: 'u2',
    name: 'Pedro Oliveira',
    email: 'pedro@email.com',
    password: '123456',
    birthDate: DateTime(2001, 1, 22),
  ),
  Client(
    id: 'u3',
    name: 'Marcos Lima',
    email: 'marcos@email.com',
    password: '123456',
    birthDate: DateTime(1985, 9, 3),
  ),
  Client(
    id: 'u4',
    name: 'Felipe Costa',
    email: 'felipe@email.com',
    password: '123456',
    birthDate: DateTime(1993, 12, 18),
  ),
  Client(
    id: 'u5',
    name: 'Gustavo Ramos',
    email: 'gustavo@email.com',
    password: '123456',
    birthDate: DateTime(2000, 6, 30),
  ),
  Client(
    id: 'u6',
    name: 'Bruno Martins',
    email: 'bruno@email.com',
    password: '123456',
    birthDate: DateTime(1997, 4, 8),
  ),
];

// ========== APPOINTMENTS ==========
// Monta uma data relativa a hoje: _dayAt(-1, 16, 0) = ontem às 16:00.
// Assim os mocks sempre têm passado, hoje e futuro, em qualquer dia que o app rodar.
DateTime _dayAt(int daysFromToday, int hour, int minute) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day + daysFromToday, hour, minute);
}

final List<Appointment> mockAppointments = [
  // ---------- Passado ----------
  Appointment(
    id: 'a1',
    clientId: 'u1',
    barberId: 'b1',
    serviceId: 's1',
    dateTime: _dayAt(-3, 10, 0),
    status: AppointmentStatus.concluido,
    price: 45.0,
    durationMinutes: 30,
  ),
  Appointment(
    id: 'a2',
    clientId: 'u2',
    barberId: 'b2',
    serviceId: 's2',
    dateTime: _dayAt(-3, 14, 30),
    status: AppointmentStatus.concluido,
    price: 35.0,
    durationMinutes: 30,
  ),
  Appointment(
    id: 'a3',
    clientId: 'u3',
    barberId: 'b3',
    serviceId: 's3',
    dateTime: _dayAt(-2, 9, 0),
    status: AppointmentStatus.cancelado,
    price: 70.0,
    durationMinutes: 60,
  ),
  Appointment(
    id: 'a4',
    clientId: 'u5',
    barberId: 'b2',
    serviceId: 's4',
    dateTime: _dayAt(-1, 11, 0),
    status: AppointmentStatus.concluido,
    price: 20.0,
    durationMinutes: 15,
  ),
  // Passado e ainda "agendado": serve para testar o bloqueio de edição.
  Appointment(
    id: 'a5',
    clientId: 'u4',
    barberId: 'b1',
    serviceId: 's1',
    dateTime: _dayAt(-1, 16, 0),
    status: AppointmentStatus.agendado,
    price: 45.0,
    durationMinutes: 30,
  ),

  // ---------- Hoje ----------
  Appointment(
    id: 'a6',
    clientId: 'u6',
    barberId: 'b1',
    serviceId: 's1',
    dateTime: _dayAt(0, 17, 0),
    status: AppointmentStatus.agendado,
    price: 45.0,
    durationMinutes: 30,
  ),
  Appointment(
    id: 'a7',
    clientId: 'u2',
    barberId: 'b2',
    serviceId: 's3',
    dateTime: _dayAt(0, 17, 30),
    status: AppointmentStatus.agendado,
    price: 70.0,
    durationMinutes: 60,
  ),

  // ---------- Futuro ----------
  // a8 e a9: mesmo horário, barbeiros diferentes -> válido.
  // Teste de conflito: tentar criar outro com o Carlos (b1) amanhã às 10:00.
  Appointment(
    id: 'a8',
    clientId: 'u3',
    barberId: 'b1',
    serviceId: 's1',
    dateTime: _dayAt(1, 10, 0),
    status: AppointmentStatus.agendado,
    price: 45.0,
    durationMinutes: 30,
  ),
  Appointment(
    id: 'a9',
    clientId: 'u4',
    barberId: 'b2',
    serviceId: 's2',
    dateTime: _dayAt(1, 10, 0),
    status: AppointmentStatus.agendado,
    price: 35.0,
    durationMinutes: 30,
  ),
  Appointment(
    id: 'a10',
    clientId: 'u5',
    barberId: 'b3',
    serviceId: 's1',
    dateTime: _dayAt(2, 15, 0),
    status: AppointmentStatus.agendado,
    price: 45.0,
    durationMinutes: 30,
  ),
  // Cancelado no futuro: não deve aparecer em "próximos agendamentos".
  Appointment(
    id: 'a11',
    clientId: 'u1',
    barberId: 'b1',
    serviceId: 's5',
    dateTime: _dayAt(3, 9, 30),
    status: AppointmentStatus.cancelado,
    price: 15.0,
    durationMinutes: 15,
  ),
  Appointment(
    id: 'a12',
    clientId: 'u6',
    barberId: 'b1',
    serviceId: 's3',
    dateTime: _dayAt(5, 14, 0),
    status: AppointmentStatus.agendado,
    price: 70.0,
    durationMinutes: 60,
  ),
];
