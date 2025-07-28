function showPayment() {
  document.getElementById('reservationForm').style.display = 'none';
  document.getElementById('paymentStep').style.display = 'block';
}
function showWeChat() {
  document.getElementById('paymentStep').style.display = 'none';
  document.getElementById('wechatStep').style.display = 'block';
}
function showActivity() {
  document.getElementById('reservationForm').style.display = 'none';
  document.getElementById('activityStep').style.display = 'block';
}
function showBooking() {
  document.getElementById('activityStep').style.display = 'none';
  document.getElementById('bookingStep').style.display = 'block';
}
function showPaymentInfo() {
  document.getElementById('bookingStep').style.display = 'none';
  document.getElementById('paymentStep').style.display = 'block';
}

// 投诉举报表单处理
function submitComplaint(event) {
  event.preventDefault();
  
  const form = event.target;
  const formData = new FormData(form);
  
  // 验证必填字段
  const requiredFields = ['reportType', 'reportContent', 'contactName', 'contactPhone'];
  let isValid = true;
  
  requiredFields.forEach(field => {
    const value = formData.get(field);
    if (!value || value.trim() === '') {
      isValid = false;
      alert('请填写所有必填字段');
      return;
    }
  });
  
  if (!isValid) return;
  
  // 模拟提交成功
  alert('投诉举报已提交，我们将在1个工作日内与您联系确认。\n\n举报编号：' + Date.now());
  
  // 清空表单
  form.reset();
}

// 页面加载完成后绑定表单提交事件
document.addEventListener('DOMContentLoaded', function() {
  const complaintForm = document.querySelector('.report-form form');
  if (complaintForm) {
    complaintForm.addEventListener('submit', submitComplaint);
  }
}); 