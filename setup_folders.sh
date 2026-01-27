# Create the script file
cat > setup_folders.sh << 'EOF'
#!/bin/bash

# APR eSIM - Automated Folder Structure Setup
echo "🚀 Creating APR eSIM Professional Folder Structure..."
echo ""

# Core folders
mkdir -p lib/core/constants
mkdir -p lib/core/utils
mkdir -p lib/core/errors
mkdir -p lib/core/network

# Authentication feature
mkdir -p lib/features/authentication/data/models
mkdir -p lib/features/authentication/data/repositories
mkdir -p lib/features/authentication/data/datasources
mkdir -p lib/features/authentication/domain/entities
mkdir -p lib/features/authentication/domain/repositories
mkdir -p lib/features/authentication/domain/usecases
mkdir -p lib/features/authentication/presentation/providers
mkdir -p lib/features/authentication/presentation/screens
mkdir -p lib/features/authentication/presentation/widgets

# Storefront feature
mkdir -p lib/features/storefront/data/models
mkdir -p lib/features/storefront/data/repositories
mkdir -p lib/features/storefront/data/datasources
mkdir -p lib/features/storefront/domain/entities
mkdir -p lib/features/storefront/domain/repositories
mkdir -p lib/features/storefront/domain/usecases
mkdir -p lib/features/storefront/presentation/providers
mkdir -p lib/features/storefront/presentation/screens
mkdir -p lib/features/storefront/presentation/widgets

# eSIM feature
mkdir -p lib/features/esim/data/models
mkdir -p lib/features/esim/data/repositories
mkdir -p lib/features/esim/data/datasources
mkdir -p lib/features/esim/domain/entities
mkdir -p lib/features/esim/domain/repositories
mkdir -p lib/features/esim/domain/usecases
mkdir -p lib/features/esim/presentation/providers
mkdir -p lib/features/esim/presentation/screens
mkdir -p lib/features/esim/presentation/widgets

# Payment feature
mkdir -p lib/features/payment/data/repositories
mkdir -p lib/features/payment/data/datasources
mkdir -p lib/features/payment/domain/repositories
mkdir -p lib/features/payment/domain/usecases
mkdir -p lib/features/payment/presentation/providers
mkdir -p lib/features/payment/presentation/screens
mkdir -p lib/features/payment/presentation/widgets

# Profile feature
mkdir -p lib/features/profile/data/models
mkdir -p lib/features/profile/data/repositories
mkdir -p lib/features/profile/domain/entities
mkdir -p lib/features/profile/domain/repositories
mkdir -p lib/features/profile/presentation/providers
mkdir -p lib/features/profile/presentation/screens
mkdir -p lib/features/profile/presentation/widgets

# Referral feature
mkdir -p lib/features/referral/data/models
mkdir -p lib/features/referral/data/repositories
mkdir -p lib/features/referral/domain/entities
mkdir -p lib/features/referral/domain/repositories
mkdir -p lib/features/referral/presentation/providers
mkdir -p lib/features/referral/presentation/screens
mkdir -p lib/features/referral/presentation/widgets

# Shared resources
mkdir -p lib/shared/widgets
mkdir -p lib/shared/theme

# Create placeholder .gitkeep files
find lib -type d -empty -exec touch {}/.gitkeep \;

echo "✅ Folder structure created successfully!"
echo ""
echo "📁 You should now see this structure in VS Code Explorer"
