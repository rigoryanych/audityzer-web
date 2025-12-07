import express from 'express';
import cors from 'cors';

const app = express();
const PORT = process.env.PORT || 3001;

app.use(cors());
app.use(express.json());

// Здоровье сервиса
app.get('/health', (req, res) => {
  res.json({ status: 'ok', message: 'AUDITYZER API is running' });
});

// Маршрут для получения услуг аудита
app.get('/api/audit-services', (req, res) => {
  res.json({
    services: [
      { id: 1, name: 'Financial Audit', description: 'Comprehensive financial audit services' },
      { id: 2, name: 'Compliance Audit', description: 'Regulatory compliance verification' },
      { id: 3, name: 'IT Audit', description: 'Information technology systems audit' },
    ],
  });
});

// Маршрут для платежей
app.post('/api/payments', (req, res) => {
  res.json({
    status: 'payment_created',
    message: 'Payment processing initiated',
    transactionId: Math.random().toString(36).substr(2, 9),
  });
});

app.listen(PORT, () => {
  console.log(`AUDITYZER API server running on port ${PORT}`);
});
