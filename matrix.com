<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IRCTC Web Connect - Railway Booking Portal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        :root {
            --primary: #e67a00;
            --secondary: #0066b3;
            --light: #f8f9fa;
            --dark: #343a40;
            --success: #28a745;
            --warning: #ffc107;
            --danger: #dc3545;
            --gray: #6c757d;
        }
        
        body {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            color: var(--dark);
            min-height: 100vh;
            padding-bottom: 50px;
        }
        
        .container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 15px;
        }
        
        /* Header Styles */
        header {
            background: linear-gradient(to right, var(--secondary) 0%, var(--primary) 100%);
            color: white;
            padding: 15px 0;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 100;
        }
        
        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .logo {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .logo-icon {
            font-size: 2.5rem;
            color: white;
        }
        
        .logo-text {
            font-size: 1.8rem;
            font-weight: 700;
        }
        
        .logo-subtext {
            font-size: 0.9rem;
            opacity: 0.9;
        }
        
        .nav-links {
            display: flex;
            gap: 25px;
        }
        
        .nav-links a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 8px 15px;
            border-radius: 30px;
            transition: all 0.3s ease;
        }
        
        .nav-links a:hover, .nav-links a.active {
            background: rgba(255, 255, 255, 0.2);
        }
        
        .user-actions {
            display: flex;
            gap: 15px;
            align-items: center;
        }
        
        .btn {
            padding: 10px 20px;
            border-radius: 30px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-primary {
            background: white;
            color: var(--primary);
        }
        
        .btn-primary:hover {
            background: #f0f0f0;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        
        .btn-outline {
            background: transparent;
            border: 2px solid white;
            color: white;
        }
        
        .btn-outline:hover {
            background: rgba(255, 255, 255, 0.1);
        }
        
        /* Hero Section */
        .hero {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('https://images.unsplash.com/photo-1506929562872-bb421503ef21?ixlib=rb-4.0.3') no-repeat center center;
            background-size: cover;
            color: white;
            padding: 80px 0;
            text-align: center;
            border-radius: 0 0 20px 20px;
            margin-bottom: 40px;
        }
        
        .hero h1 {
            font-size: 3rem;
            margin-bottom: 20px;
        }
        
        .hero p {
            font-size: 1.2rem;
            max-width: 700px;
            margin: 0 auto 30px;
            opacity: 0.9;
        }
        
        .hero-btns {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
        }
        
        .btn-lg {
            padding: 15px 30px;
            font-size: 1.1rem;
        }
        
        /* Booking Form */
        .booking-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            padding: 30px;
            margin-bottom: 40px;
        }
        
        .section-title {
            font-size: 1.8rem;
            color: var(--secondary);
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid var(--primary);
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 25px;
        }
        
        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        
        .form-group label {
            font-weight: 600;
            color: var(--dark);
            font-size: 0.95rem;
        }
        
        .form-control {
            padding: 14px;
            border: 1px solid #ced4da;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: var(--primary);
            outline: none;
            box-shadow: 0 0 0 3px rgba(230, 122, 0, 0.2);
        }
        
        .form-row {
            display: flex;
            gap: 15px;
            margin-top: 15px;
        }
        
        /* Features Section */
        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            margin: 40px 0;
        }
        
        .feature-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            padding: 25px;
            transition: all 0.3s ease;
            border: 1px solid #e9ecef;
        }
        
        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }
        
        .feature-icon {
            font-size: 2.5rem;
            color: var(--primary);
            margin-bottom: 20px;
        }
        
        .feature-card h3 {
            font-size: 1.4rem;
            margin-bottom: 15px;
            color: var(--secondary);
        }
        
        /* Trains Section */
        .trains {
            margin: 50px 0;
        }
        
        .train-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            padding: 25px;
            margin-bottom: 25px;
            display: flex;
            gap: 20px;
            align-items: center;
            border-left: 4px solid var(--primary);
        }
        
        .train-info {
            flex: 1;
        }
        
        .train-number {
            font-weight: 700;
            color: var(--secondary);
            font-size: 1.2rem;
        }
        
        .train-name {
            font-weight: 600;
            font-size: 1.1rem;
            margin: 5px 0;
        }
        
        .train-route {
            display: flex;
            align-items: center;
            gap: 10px;
            margin: 10px 0;
            color: var(--gray);
        }
        
        .train-timing {
            display: flex;
            gap: 15px;
            margin-top: 10px;
        }
        
        .timing-box {
            background: #f8f9fa;
            padding: 10px 15px;
            border-radius: 8px;
            text-align: center;
        }
        
        .timing-label {
            font-size: 0.85rem;
            color: var(--gray);
        }
        
        .timing-value {
            font-weight: 700;
            margin-top: 5px;
        }
        
        .train-availability {
            min-width: 180px;
            text-align: center;
        }
        
        .availability-status {
            font-weight: 700;
            color: var(--success);
            margin-bottom: 10px;
        }
        
        /* App Download Section */
        .app-download {
            background: linear-gradient(to right, var(--secondary) 0%, #004a86 100%);
            color: white;
            padding: 50px 0;
            border-radius: 20px;
            margin: 50px 0;
        }
        
        .app-container {
            display: flex;
            align-items: center;
            gap: 50px;
            flex-wrap: wrap;
        }
        
        .app-content {
            flex: 1;
            min-width: 300px;
        }
        
        .app-image {
            flex: 1;
            text-align: center;
            min-width: 300px;
        }
        
        .app-image img {
            max-width: 250px;
            filter: drop-shadow(0 10px 20px rgba(0, 0, 0, 0.2));
        }
        
        .app-badges {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }
        
        .badge {
            background: white;
            border-radius: 10px;
            padding: 10px 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            color: var(--dark);
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .badge:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        /* Footer */
        footer {
            background: var(--dark);
            color: white;
            padding: 40px 0 20px;
            margin-top: 50px;
            border-radius: 20px 20px 0 0;
        }
        
        .footer-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
            margin-bottom: 30px;
        }
        
        .footer-column h3 {
            font-size: 1.3rem;
            margin-bottom: 20px;
            color: var(--primary);
        }
        
        .footer-links {
            list-style: none;
        }
        
        .footer-links li {
            margin-bottom: 12px;
        }
        
        .footer-links a {
            color: #adb5bd;
            text-decoration: none;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .footer-links a:hover {
            color: white;
            padding-left: 5px;
        }
        
        .copyright {
            text-align: center;
            padding-top: 20px;
            border-top: 1px solid #495057;
            color: #6c757d;
            font-size: 0.9rem;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .header-container {
                flex-direction: column;
                gap: 20px;
            }
            
            .nav-links {
                flex-wrap: wrap;
                justify-content: center;
            }
            
            .hero h1 {
                font-size: 2.2rem;
            }
            
            .app-container {
                flex-direction: column;
                text-align: center;
            }
            
            .app-badges {
                justify-content: center;
            }
            
            .train-card {
                flex-direction: column;
                text-align: center;
            }
            
            .train-timing {
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header>
        <div class="container header-container">
            <div class="logo">
                <div class="logo-icon">
                    <i class="fas fa-train"></i>
                </div>
                <div>
                    <div class="logo-text">IRCTC Web Connect</div>
                    <div class="logo-subtext">Official Web Integration Portal</div>
                </div>
            </div>
            
            <nav class="nav-links">
                <a href="#" class="active"><i class="fas fa-home"></i> Home</a>
                <a href="#"><i class="fas fa-ticket-alt"></i> Book Tickets</a>
                <a href="#"><i class="fas fa-history"></i> Booking History</a>
                <a href="#"><i class="fas fa-percentage"></i> Offers</a>
                <a href="#"><i class="fas fa-headset"></i> Support</a>
            </nav>
            
            <div class="user-actions">
                <button class="btn btn-outline"><i class="fas fa-user"></i> Sign In</button>
                <button class="btn btn-primary"><i class="fas fa-user-plus"></i> Register</button>
            </div>
        </div>
    </header>
    
    <!-- Hero Section -->
    <section class="hero">
        <div class="container">
            <h1>India's Railway Journey Starts Here</h1>
            <p>Book train tickets, check PNR status, view train schedules, and manage your bookings all in one place</p>
            <div class="hero-btns">
                <button class="btn btn-primary btn-lg"><i class="fas fa-train"></i> Book Tickets</button>
                <button class="btn btn-outline btn-lg"><i class="fas fa-search"></i> Check PNR Status</button>
                <button class="btn btn-outline btn-lg"><i class="fas fa-list"></i> View Schedule</button>
            </div>
        </div>
    </section>
    
    <div class="container">
        <!-- Booking Form -->
        <section class="booking-card">
            <h2 class="section-title"><i class="fas fa-search"></i> Find Trains</h2>
            <div class="form-grid">
                <div class="form-group">
                    <label for="from">From Station</label>
                    <input type="text" id="from" class="form-control" placeholder="Source Station">
                </div>
                <div class="form-group">
                    <label for="to">To Station</label>
                    <input type="text" id="to" class="form-control" placeholder="Destination Station">
                </div>
                <div class="form-group">
                    <label for="date">Journey Date</label>
                    <input type="date" id="date" class="form-control">
                </div>
                <div class="form-group">
                    <label for="class">Class</label>
                    <select id="class" class="form-control">
                        <option value="">All Classes</option>
                        <option value="1A">AC First Class (1A)</option>
                        <option value="2A">AC 2 Tier (2A)</option>
                        <option value="3A">AC 3 Tier (3A)</option>
                        <option value="SL">Sleeper (SL)</option>
                        <option value="CC">AC Chair Car (CC)</option>
                    </select>
                </div>
            </div>
            <div class="form-row">
                <button class="btn btn-primary"><i class="fas fa-search"></i> Search Trains</button>
                <button class="btn btn-outline" style="color: var(--dark); border-color: #ced4da;">
                    <i class="fas fa-sync-alt"></i> Reset
                </button>
            </div>
        </section>
        
        <!-- Features Section -->
        <section>
            <h2 class="section-title"><i class="fas fa-star"></i> IRCTC Services</h2>
            <div class="features">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-ticket-alt"></i>
                    </div>
                    <h3>Easy Ticket Booking</h3>
                    <p>Book train tickets in less than a minute with our streamlined process. Secure your seat with instant confirmation.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-mobile-alt"></i>
                    </div>
                    <h3>Mobile Integration</h3>
                    <p>Access your bookings on mobile, receive e-tickets, and get live updates through the IRCTC mobile app.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-percentage"></i>
                    </div>
                    <h3>Special Offers</h3>
                    <p>Exclusive discounts, cashback offers, and special deals for frequent travelers and online bookings.</p>
                </div>
            </div>
        </section>
        
        <!-- Trains Section -->
        <section class="trains">
            <h2 class="section-title"><i class="fas fa-train"></i> Popular Trains</h2>
            
            <div class="train-card">
                <div class="train-info">
                    <div class="train-number">12001</div>
                    <div class="train-name">Shatabdi Express</div>
                    <div class="train-route">
                        <span>New Delhi (NDLS)</span>
                        <i class="fas fa-arrow-right"></i>
                        <span>Bhopal Junction (BPL)</span>
                    </div>
                    <div class="train-timing">
                        <div class="timing-box">
                            <div class="timing-label">Departure</div>
                            <div class="timing-value">06:00 AM</div>
                        </div>
                        <div class="timing-box">
                            <div class="timing-label">Arrival</div>
                            <div class="timing-value">11:30 AM</div>
                        </div>
                        <div class="timing-box">
                            <div class="timing-label">Duration</div>
                            <div class="timing-value">5h 30m</div>
                        </div>
                    </div>
                </div>
                <div class="train-availability">
                    <div class="availability-status">Seats Available</div>
                    <button class="btn btn-primary">Book Now</button>
                </div>
            </div>
            
            <div class="train-card">
                <div class="train-info">
                    <div class="train-number">12951</div>
                    <div class="train-name">Mumbai Rajdhani</div>
                    <div class="train-route">
                        <span>Mumbai Central (BCT)</span>
                        <i class="fas fa-arrow-right"></i>
                        <span>New Delhi (NDLS)</span>
                    </div>
                    <div class="train-timing">
                        <div class="timing-box">
                            <div class="timing-label">Departure</div>
                            <div class="timing-value">05:00 PM</div>
                        </div>
                        <div class="timing-box">
                            <div class="timing-label">Arrival</div>
                            <div class="timing-value">08:45 AM</div>
                        </div>
                        <div class="timing-box">
                            <div class="timing-label">Duration</div>
                            <div class="timing-value">15h 45m</div>
                        </div>
                    </div>
                </div>
                <div class="train-availability">
                    <div class="availability-status">Limited Seats</div>
                    <button class="btn btn-primary">Book Now</button>
                </div>
            </div>
        </section>
        
        <!-- App Download Section -->
        <section class="app-download">
            <div class="container app-container">
                <div class="app-content">
                    <h2>Get the IRCTC App</h2>
                    <p>Download the official IRCTC Rail Connect app for faster bookings, exclusive offers, and seamless travel experience on your mobile device.</p>
                    
                    <div class="app-badges">
                        <div class="badge">
                            <i class="fab fa-google-play"></i>
                            <div>
                                <div style="font-size: 0.8rem;">GET IT ON</div>
                                <div>Google Play</div>
                            </div>
                        </div>
                        <div class="badge">
                            <i class="fab fa-apple"></i>
                            <div>
                                <div style="font-size: 0.8rem;">Download on the</div>
                                <div>App Store</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="app-image">
                    <img src="https://cdn-icons-png.flaticon.com/512/0/747.png" alt="IRCTC Mobile App">
                </div>
            </div>
        </section>
    </div>
    
    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="footer-grid">
                <div class="footer-column">
                    <h3>IRCTC Web Connect</h3>
                    <p style="color: #adb5bd; line-height: 1.6; margin-bottom: 20px;">
                        The official web portal for IRCTC services. Book train tickets, check PNR status, and manage your railway journey.
                    </p>
                </div>
                
                <div class="footer-column">
                    <h3>Quick Links</h3>
                    <ul class="footer-links">
                        <li><a href="#"><i class="fas fa-chevron-right"></i> Book Tickets</a></li>
                        <li><a href="#"><i class="fas fa-chevron-right"></i> Cancel Tickets</a></li>
                        <li><a href="#"><i class="fas fa-chevron-right"></i> PNR Status</a></li>
                        <li><a href="#"><i class="fas fa-chevron-right"></i> Train Schedule</a></li>
                        <li><a href="#"><i class="fas fa-chevron-right"></i> Seat Availability</a></li>
                    </ul>
                </div>
                
                <div class="footer-column">
                    <h3>Information</h3>
                    <ul class="footer-links">
                        <li><a href="#"><i class="fas fa-chevron-right"></i> About IRCTC</a></li>
                        <li><a href="#"><i class="fas fa-chevron-right"></i> Contact Us</a></li>
                        <li><a href="#"><i class="fas fa-chevron-right"></i> FAQs</a></li>
                        <li><a href="#"><i class="fas fa-chevron-right"></i> Terms & Conditions</a></li>
                        <li><a href="#"><i class="fas fa-chevron-right"></i> Privacy Policy</a></li>
                    </ul>
                </div>
                
                <div class="footer-column">
                    <h3>Contact</h3>
                    <ul class="footer-links">
                        <li><a href="#"><i class="fas fa-phone-alt"></i> Customer Care: 139</a></li>
                        <li><a href="#"><i class="fas fa-envelope"></i> care@irctc.co.in</a></li>
                        <li><a href="#"><i class="fas fa-map-marker-alt"></i> IRCTC Centre, New Delhi</a></li>
                    </ul>
                    <div style="margin-top: 20px; display: flex; gap: 15px;">
                        <a href="#" style="font-size: 1.5rem;"><i class="fab fa-facebook"></i></a>
                        <a href="#" style="font-size: 1.5rem;"><i class="fab fa-twitter"></i></a>
                        <a href="#" style="font-size: 1.5rem;"><i class="fab fa-instagram"></i></a>
                        <a href="#" style="font-size: 1.5rem;"><i class="fab fa-youtube"></i></a>
                    </div>
                </div>
            </div>
            
            <div class="copyright">
                © 2023 IRCTC Web Connect. This is a demonstration interface. Indian Railway Catering and Tourism Corporation Ltd.
            </div>
        </div>
    </footer>
    
    <script>
        // Set default date to tomorrow
        const tomorrow = new Date();
        tomorrow.setDate(tomorrow.getDate() + 1);
        const formattedDate = tomorrow.toISOString().split('T')[0];
        document.getElementById('date').value = formattedDate;
        
        // Add active class to clicked nav items
        const navLinks = document.querySelectorAll('.nav-links a');
        navLinks.forEach(link => {
            link.addEventListener('click', function() {
                navLinks.forEach(item => item.classList.remove('active'));
                this.classList.add('active');
            });
        });
        
        // Booking buttons
        const bookButtons = document.querySelectorAll('.btn-primary');
        bookButtons.forEach(button => {
            if (button.textContent.includes('Book')) {
                button.addEventListener('click', function() {
                    alert('Booking functionality would connect to IRCTC services in the real application.');
                });
            }
        });
    </script>
</body>
</html>
